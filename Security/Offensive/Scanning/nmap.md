# NMap
`nmap -A -p0- 10.10.10.10` - All ports, service version, os, etc

`nmap 192.168.1.1 -vvv` - Single IP address.

`nmap 192.168.1.1/24` - CIDR range.

`nmap 192.168.1.1-100` - Custom range.

`nmap -iL ip-list.txt` - Use a source file.

`nmap 192.168.1.1 -p ` - Specify all ports or a range.

`nmap 192.168.1.1 -sU ` - Scan UDP 

`nmap 192.168.1.1 -Pn` - No ping scan treats all hosts as "up" if regular ICMP does not work.

`nmap 192.168.1.1 -oA` - A gets all outputs.

`nmap 192.168.1.1 -T 5` - Scan timing. 5 is fastest 4 recomended. 


## Common Flags
`-sC` - use default nmap scripts

`-sS` - TCP SYN port scan

`-sU` - UDP port scan

`-sV` - get service versions.

`-a` - Aggressive scan.

`-O` - Operating system scan.

`-sO` - Protocol scan.

`--script vuln` - Checks against common vulnerabilities. 

`nmap -sV -sC -vvv 192.168.1.1` - Service version, default scripts, all output.

## Scan a Range of IP Addresses and output them to a text file
`nmap 192.168.1.1/24 -sn -n -oG - | awk '/Up$/{print $2}' > ip-list.txt`

`-n` - Don't resolve DNS.

`-sn` - ping scan, no ports.

`-oG -` - sends "grepable" output to stdout, which gets piped to awk.

`/Up$/` - Regex to select lines which end with "Up"

`{print $2}` - print the second whitespace (ip address)

`> ip-list.txt` - Output to file

## Perform a simple port scan
```sh
nmap -p0- 10.10.10.10

```

## SMB Enumeration
```sh
nmap 10.10.10.10 -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse
```
