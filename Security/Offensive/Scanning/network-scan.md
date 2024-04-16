# Network Scanning

1. Map out the target network using `nmap` and save the output to a file if the device is online. This command will 

`-sn` - Ping scan, no ports
`-n` - no dns
`-oG -` - grepable output (the - requests output to be sent to stdout)

`nmap 192.168.1.1/24 -sn -n -oG - | awk '/Up$/{print $2}' > ip-list.txt`

Note that the pattern passed to `awk` is the ouput of the `-oG -`

The result will be a file containing an ip on each line.

```
192.168.1.100
192.168.1.110
192.168.1.120
```

2. Scan a device to identify it.
This scan will produce as much output as possible `-vvv` but take a long time. We want to see the services running on each port.
`nmap 192.168.1.100 -sV sC -vvv `


3. Target a service and map it out
Look for any services that could be exploited and begin [enumerating](Enumeration/README.md) it.

```
21/tcp  open    ftp syn-ack Microsoft ftp
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| Can't get directory listing: TIMEOUT
```

3. Send Requests & Pull Banners
Run the netcat command on port 80 and then send a GET request to view the server banner.

```sh
nc -vn 192.168.1.80 80
 GET / HTTP/1.0

HTTP/1.1 200 OK
Server:nginx
Content-Type: text/html
Content-Encoding: gzip

[more]
```
