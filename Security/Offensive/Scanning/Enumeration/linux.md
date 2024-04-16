# Linux Enumeration
| Command | Description |
| ------- | ----------- |
| `ls /etc/*-release` | Distribution information |
| `hostname` | System Name |
| `cat /etc/passwd` | User names |
| `cat /etc/group` | Groups |
| `cat /etc/shadow` | Password hashes |
| `cat /var/mail` | Mail directories |
| `ls /usr/bin` | Installed applications |
| `ls /usr/sbin` | Installed applications |
| `rpm -qa` | Query all packages on RPM-based |
| `dpkg -l` | List installed packages on Debian-based |
| `who` | Logged in user |
| `whoami` | Current user id |
| `w` | Logged in user activity |
| `id` | effective user and group IDS |
| `last` | Last logged in users |
| `sudo -l` | Lists allowed command for invoking user |
| `ip address show` | Networking information |
| `ip a s` | Shorthand for above |
| `cat /etc/resolve.conf` | DNS Servers |

## Netstat 
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

List Programs on TCP Sockets
`sudo netstat -plt`

All connections in numeric format
`sudo netstat -atupn`

`sudo lsof` - List open files
`sudo lsof -i` - Internet & network connections
`sudo lsof -i:25` - Port 25

## Running Services
`ps` - Running processes
`ps -e` - All processes
`ps -ef` - Full format
`ps -el` - Long Format

## BSD Syntax
`ps aux` - All process, Details aboout user
`ps axjf` - Process tree. F stands for forest
