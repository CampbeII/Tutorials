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
Basic usage:
```sh
gobuster dir -u http://evil.com -w wordlist.txt

```
Enumerate directories for file extensions:
```sh
gobuster dir -u http://evil.com -w rockyou.txt -x jpg,txt
```
