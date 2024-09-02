# Privilege Escalation

| Type | Description |
| ---- | ----------- |
| Horizontal | Different user, same permission level |
| Vertical | Higher pe    rmissions |

## Users
Any account in /etc/passwd in the 1000s will be a regular user account:
```sh
cat /etc/passwd
```

## Shells
Find available shells:
```sh
cat /etc/shells
```

## Cronjobs
```sh
cat /etc/crontab
```

## Recent file changes

Use ls in current directory:
`-A` - All files except `.` and `..`
`-r` - Reverse order while sorting
`t` - Sort by time

```
ls -Art | tail -n 1
```

Using recursive find
`find /dir/path -type f` - All files in dir
`printf "%T@ %p\n"` - Print a new line for each file where `%T@` is the float seconds. `%p` is the filename path
`sort -n` - sort on first column and treat the token as numerical
`cut -d' ' -f 2-` - split each line using a space and print all tokens at the second index. Note `-f2` will only print a single token

```sh
find /dir/path -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1
```

## Exploiting SUID Files:

## SUID Binary:
A typical permission consists of 7 bits `read (4)`, `write (2)`, `read (1)`. When the special bit is set to `4` it because `SUID` when the bit is `2` it becomes `SGID`
```sh
SUID:
rws-rwx-rwx

GUID:
rwx-rws-rwx
```

Finding SUID Binaries:
```sh
find / -perm -u=s -type f 2>/dev/null
```

Creating a new entry in `/etc/passwd`
```sh
openssl passwd -1 -last [salt][password]

echo "newusername:x:0:0:root:/root:/bin/bash" >> /etc/passwd

su newusername
```

## Linux Tooling

### LinEnum
Bash script to enumerate common linux privesc vulnerabilities
1. Download a copy:
[Download](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh

2. Running:
```sh
sudo chmod +x LinEnum.sh
```

3. Understanditg the output
- Kernel information indicates if there is an exploit available in the kernel
- File output shows us the files anyone can write to
- SUID files - Special permissions given to file
- Crontab Contents are scheduled jobs

