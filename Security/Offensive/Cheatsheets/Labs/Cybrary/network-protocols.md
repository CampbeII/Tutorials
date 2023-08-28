# Network Protocol Lab
The goal of this lab is to explore the network and develop basic discovery skills.

1. Map out the target network using nmap and save the output to a file if the device is online. This command will 
`-sn` - Ping scan, no ports
`-n` - no dns
`-oG -` - grepable output (the - requests output to be sent to stdout)

`nmap 192.168.1.1/24 -sn -n -oG - | awk '/Up$/{print $2}' > ip-list.txt`

Note that the pattern passed to `awk` is the ouput of the `-oG -`

The result will be a file containing an ip on each line.
```
192.168.1.100
192.168.1.200
```

2. Choose a target and perform a port scan
`nc -nv -w 1 -z 192.168.1.100` 
