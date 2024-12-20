# Webserver Enumeration

Scan for common vulnerabilities using nmap.
```
nmap -sV -sC 192.168.1.1 --script=vuln -p 80
```

## Directory Busting
A brute force tactic to determine the names of accessible directories.

### DirB
Built into Kali and it's wordlists can be accessed: `/usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt`

Scan a website:
```
dirb http://site.com -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt
```

### GoBuster
```sh
gobuster dir -u http://site.com -w /usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt

gobuster dir -u http://site.com/assets -w wordlist.txt -x php,jpg,png
```

## Files of inerest

### robots.txt
This file tells web crawlers what files and directories to ignore. As a result, it may reveal sensitive information.

### Source code
Could reveal hints about technologies, links, or comments

### Developer tools
- check session cookies
- check the network tab

## VHOST Fuzzing
If you receive a destination unreachable try to add an entry to `/etc/hosts`
```sh
10.10.10.10     domaintoresolve.odd     test
```

Use gobuster to enumerate
```sh
gobuster vhost --url 10.10.10.10 --wordlist /usr/share/SecLists/Discovery/DNS/subdomains-top1million-110000.txt --append-domain
```
