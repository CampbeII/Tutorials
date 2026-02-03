# GoBuster

## Flags
| Flag | Description |
| ---- | ----------- |
| `-e` | Full URLs |
| `-u` | Target URL |
| `-w` | Wordlist path |
| `-U` | Username |
| `-P` | Password|
| `-p` | Proxy |
| `-c` | Http cookie |

## Examples

### 1. Basic usage:
```sh
gobuster dir -u http://evil.com -w wordlist.txt
```

### 2. Enumerate directories for file extensions:
```sh
gobuster dir -u http://evil.com -w rockyou.txt -x jpg,txt
```

### 3. VHOSTs
/etc/hosts
```sh
10.10.10.10     domaintoresolve.odd     test
```

Use gobuster to enumerate
```sh
gobuster vhost --url 10.10.10.10 --wordlist /usr/share/SecLists/Discovery/DNS/subdomains-top1million-110000.txt --append-domain
```
