# What is Netcat?
Read and write to network connections using TCP or UDP

# Port Scanning
A basic scan using netcat

| Option | Description |
| ------ | ----------- |
| `-nv` | Don't resolve DNS, verbose |
| `-w 1` | sets timeout to 1 second |
| `-z` | specifies a port scan |
| `-u` | UDP mode |

`nc -nv -w 1 -z 192.168.1.1/24` 

Scan a range of ports and store the result in a file
```sh
nc -nv -w 1 -z 10.10.10.10 1-65535 2>&1 | awk '/succeeded!$/{print $3}' > port-scan.txt 2>&1
```
