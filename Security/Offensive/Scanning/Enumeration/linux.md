# Linux Enumeration

## Directories
| Path | Description |
| ------- | ----------- |
| `ls /etc/*-release` | Distribution information |
| `ls /usr/bin` | Installed applications |
| `ls /usr/sbin` | Installed applications |
| `/proc/version` | System processes, kernel, compiler |
| `/etc/passwd` | User names |
| `/etc/group` | Groups |
| `/etc/shadow` | Password hashes |
| `/etc/issue` | Operating system, customizations, changes |
| `/etc/resolve.conf` | DNS Servers |
| `/var/mail` | Mail directories |

## User
| Command | Description |
| ------- | ----------- |
| `who` | Logged in user |
| `whoami` | Current user id |
| `w` | Logged in user activity |
| `sudo -l` | Lists allowed commands for invoking user |
| `id` | Privilege levels & group IDS |
| `env` | Show environment variables |

## System Information
| Command | Description |
| ------- | ----------- |
| `hostname` | System Name |
| `uname -a` | Print system & kernel information |
| `rpm -qa` | Query all packages on RPM-based |
| `dpkg -l` | List installed packages on Debian-based |
| `last` | Last logged in users |
| `history` | Terminal command history |

## Networking
| Command | Description |
| ------- | ----------- |
| `ifconfig` | Network interfaces |
| `ip address show` | Networking information |
| `ip a s` | Shorthand for above |
| `ip route` | Network routes|


### Netstat 
Generates less noise than `nmap`

| Option | Description |
| ------ | ----------- |
| `-a`   | show sockets |
| `-l`   | listening sockets |
| `-n`   | numeric values, no resolving |
| `-t`   | TCP |
| `-u`   | UDP |
| `-x`   | UNIX |
| `-p`   | socket pid |
| `-s`   | Network usages statistics |
| `-i`   | Interface statistics |

| CMD | Description |
| --- | ----------- |
| `-ano` | Common CTF |
| `-plt` | Progams on TCP sockets |
| `-atupn` | Numeric format |

### LSOF
| CMD | Description |
| --- | ----------- |
| `lsof` | List open files |
| `lsof -i` | Internet & network connections |
| `lsof -i:25` | Port 25 |

## Processes (PS)
| CMD | Description |
| --- | ----------- |
| `ps -A` | All running processes |
| `ps -e` | All processes |
| `ps -ef` | Full format |
| `ps -el` | Long Format |

### BSD Syntax
`ps aux` - All process, Details aboout user
`ps axjf` - Process tree. F stands for forest

## Searching
| CMD | Description |
| --- | ----------- |
| `find . -name flag1.txt` | File in current directory |
| `find . -type d -name config` | Find a directory |
| `find . -type f -perm 0777` | Find files with 777 permissios |
| `find . -perm a=x` | Find executable files |
| `find . -user test` | Find all files for test user |
| `find . -mtime 10` | Files modified last 10 days ||
| `find . -atime 10` | Accessed last 10 days |
| `find . -cmin -60` | Changed in the last hour |
| `find . -amin -60` | Access in the last hour |
| `find . -size 50M` | Find all 50MB files |
| `find . -size +50M` | Find all 50MB and above files |
| `find . -size -50M` | Find all files below 50MB |
| `find / -perm -o x -type d 2>/dev/null` | World executable files |
| `find / -perm -u=s -type f 2>/dev/null` | SUID |
