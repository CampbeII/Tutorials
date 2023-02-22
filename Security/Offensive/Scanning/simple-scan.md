# A Simple Scan

1. Map out the target network using nmap and save the output to a file if the device is online.

`nmap 192.168.1.1/24 -sn -n -oG - | awk '/Up$/{print $2}' > ip-list.txt`

The result will be a file containing an ip on each line.
```
192.168.1.100
192.168.1.110
192.168.1.203
192.168.1.211
192.168.1.170
```

2. Iterate over the file and perform a port scan on port 80

`while read l; do nc -nv -w 1 -z $l 80; done < ip-list.txt`

`l` - sets the variable l
`$l` - reference to the l variable
`80` - Port number

3. Pull the banner 
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
