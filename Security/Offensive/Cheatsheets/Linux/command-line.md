# Prompt Information
`#` - Root 

`$` - Regular 

## Get Help
`man nmap` - Show the nmap command documentation.

`nmap -h` - View command help.

`apropos` - Find commands using keywords.


`file bin` - Locate help about a file.

`history` - Command history. Access with `!100` 

`whereis` - locates programs.

# System Information
`cat /etc/os-release` - Name, Version, ID, Support URL

`uname -a` - Operating system information.

`lsb_release -a` - Distributor ID, Description Release, Codename

`hostnamectl` - hostname, machine id, boot id, os, kernel, architecture

`uname -r` -  Running Kernel

`free` - Free memory 

`df -h` - Free disk space in human readable format

## System Logs
`dmesg` - Kernel logs

`journalctl` - stdout / stderr of services, syslog, kernel logs. 

`journalctl -r` - View results in reverse order (newest -> oldest)

`journalctl -f` - Follow file by updating as new lines are added.

`journalctl -u ssh.service` - Limit to a service.

## Hardware Discovery
`lspci` - Summarize detected hardware details.

`lspci | grep Ethernet` -  Networking Adapter Information

`lspci -v -s 'lspci | grep VGA | cut -fi -d\'` - Graphics card

`lsusb` - List USB devices.

`lspcmcia` - List PCMICIA cards.

`lsdev` - Communication resources used by devices.

`lshw` - A combination of all tools. Great for reports.

`sudo dmesg | grep CPU0` - Type of CPU

## User information
`whoami` - display current user information.

`id` - user and group names. Root users are 0, regular start at 1000


`sudo -l` - All root commands.

## Files
`drwxrwxrwx` - (d) directory, (r) read, (w) write, (x) execute.

`cat filename.txt` - View the contents of a file.

`strings binaryfile` - show printable characters.

`cat filename.txt | head -n 5` - show first 5 lines.

`cat filename.txt | tail -n 5` - show last 5 lines.

## Searching
| Command | Description |
| ------- | ----------- |
| `find / -name flag.txt` | Will only print what it finds. | 
| `grep -rnw / -e 'password'` | Search line by line and match an expression. |
| `grep -v -e 'test1' -e 'test2'` | Display lines that don't match 'test1' or 'test2' |
| `grep -rin testval * | column -t | less -S` | Search testval everywhere, organize columns spaces and view output with `less` |
| `locate filename.txt` | Locate a file |


## Filtering
| Command | Description |
| ------- | ----------- |
| `cat f.txt | cut -f 1` | cut first field |
| `cat f.txt | cut -d '.' -f 1-2` | split on . print first 2 fields |
| `cat f.txt | cut -c 1` | cut first column |
| `cat f.txt | sed -n '11p'` | Print line 11 |
| `cat f.txt | sed -n '10,15p'` | Print lines 10 - 15 |
| `cat f.txt | awk 'NR < 11 {print $0}'` | Below 11 |
| `cat f.txt | awk 'NR == 11 {print $0}'` | Line 11 |

## Processes
`ps -aux` - print all running processes from all users.

`crontab` - List of scheduled jobs.

`locate file.txt | time` - Duration of process

## Networking
`ifconfig` or `ipaddr` - view network addressing
`netstat -tulpen` - Open ports
`iptables -n -L INPUT` - Open ports

