# What is Netcat?
Read and write to network connections using TCP or UDP

# Port Scanning
`nc -nv -w 1 -z 192.168.1.1/24` 

| Option | Description |
| ------ | ----------- |
| `-nv` | Don't resolve DNS, verbose |
| `-w 1` | sets timeout to 1 second |
| `-z` | specifies a port scan |
| `-u` | UDP mode |

