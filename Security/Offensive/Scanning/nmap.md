# NMap
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
`-sC` - default scripts

`-sV` - service version

`-a` - Aggressive scan.

`nmap -sV sC -vvv 192.168.1.1` - common scan

`--script vuln` - Checks against common vulnerabilities. 
