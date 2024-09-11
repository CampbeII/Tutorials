# Operating System & Software
Services come with vulnerabilities, it's best to disable unused ones.

1. Disable services 
2. Block unneeded ports
3. Avoid legacy protocols (telnet, ftp)
4. Remove id strings and version numbers from being displayed.

## Update & Upgrade Policies
Sources: `/etc/apt/sources.list`
Keep the systems updated:
```sh
apt update
apt upgrade

dnf update
yum update
```
