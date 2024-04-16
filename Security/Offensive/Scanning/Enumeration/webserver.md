# Webserver Enumeration

Scan for common vulnerabilities using nmap.
```
nmap -sV -sC 192.168.1.1 --script=vuln -p 80
```

Use dirb to brute force directories. This tool is built into Kali and it's wordlists can be accessed: `/usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt`
```
dirb http://192.168.1.1
```

## Files of inerest

### robots.txt
This file tells web crawlers what files and directories to ignore. As a result, it may reveal sensitive information.

### Source code
Could reveal hints about technologies, links, or comments

### Developer tools
- check session cookies
- check the network tab

