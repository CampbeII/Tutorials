# SMTP Enumeration
This service has two internal commands that allow for the enumeration of users:

| Command | Description |
| ------- | ----------- |
| `VRFY` | Confirm valid user names |
| `EXPN` | Actual address of users alias  & emails |

## 1. Scan ports
Nmap and Netcat can be used to test common smtp ports

```sh
nmap 192.168.1.1 --script=smtp* -p 25
nc -C 192.168.1.1 25 
smtp-user-enum -H VRFY -U users.txt -t 192.168.1.1
```

## Using Metasploit

Scanning for version:
```sh
msfconsole
search smtp_version
use 0
options
set rhosts 10.10.10.10
exploit
```

Enumerating Accounts:
```sh
back
search smtp_enumeration
use 0
options
set USER_FILE /usr/shar/wordlists/SecLists/Usernames
set RHOSTS 10.10.10.10
exploit
```
