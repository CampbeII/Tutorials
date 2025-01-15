# NMap

## Process
An `nmap` scan will go through the following process:

1. Enumerate targets
2. Discover live hosts
3. Reverse-DNS lookup
4. Scan ports
5. Detect versions
6. Detect OS
7. Traceroute
8. Scripts
9. Write Output

## Cheatsheet
| Command | Description |
| ------- | ----------- |
| `nmap -A -p0- 10.10.10.10` | All ports, service version, os, etc |
| `nmap 192.168.1.1/24` | CIDR range. |
| `nmap 192.168.1.1-100` | Custom range. |
| `nmap -iL ip-list.txt` | Use a source file. |
| `nmap 192.168.1.1 -sU ` | Scan UDP |
| `nmap 192.168.1.1 -Pn` | No ping scan treats all hosts as "up" if regular ICMP does not work. |
| `nmap 192.168.1.1 -oA` | A gets all outputs. |
| `nmap 192.168.1.1 -T 5` | Scan timing. O (stealth) -> 5 (intense) |
| `nmap --reason -vvv -d ` | Reasoning, verbose, debugging information |
| `sudo nmap -sS -Pn -p- -T5 10.10.10.10` | Fast way to scan entire range. Good for CTF |


## Common Flags
`-sC` - use default nmap scripts

`-sS` - TCP SYN port scan

`-sU` - UDP port scan

`-sV` - get service versions.

`-a` - Aggressive scan.

`-O` - Operating system scan.

`-sO` - Protocol scan.

`-oG` - Grep-able output.

`-p0-` - All ports.

`nmap -sV -sC -vvv 192.168.1.1` - Service version, default scripts, all output.

## Saving Output
There are 3 main formats:
| Option | Format | Description |
| ------ | ------ | ----------- |
| `oN` | Normal | Same as stdout |
| `oG` | Grepable | Easy searching with grep |
| `oX` | XML | Best to pass to other programs |
| `oA` | All | Saves a copy of each output |

Grepable output to AWK
```sh
nmap 192.168.1.1/24 -sn -n -oG - | awk '/Up$/{print $2}' > ip-list.txt
```


## SMB Enumeration
```sh
nmap 10.10.10.10 -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse
```


## Ping Scans
Firewalls may block ICMP traffic, it is important to try different scans.

| Echo | `nmap -PE -sn 10.10.10.10/24` |
| Timestamp | `nmap -PP -sn 10.10.10.10/24` |
| Address Mask | `nmap -PM -sn 10.10.10.10/24` |


### ARP
To perform an ARP scan without port-scanning:
```sh
nmap -PR -sn 10.10.10.10/24
```

### TCP SYN
- Send `SYN` flag
- Open port replies with `SYN/ACK`
- Closed is `RST`
```sh
nmap -PS -sn 10.10.10.10/24
```

### TCP ACK
- Set the `ACK` flag
- Host will respond with `RST` if online
- You must sudo to prevent the 3-way handshake
```sh
sudo nmap -PA -sn 10.10.10.10/24
```

### UDP Ping
Unlike TCP a UDP packet will not get a response. However, if we send a UDP packet to a UDP port we expect to get an `ICMP port unreachable` packet. This indicates the target is up.
```sh
sudo nmap -PU -n 10.10.10.10/24
```

## DNS
The default behaviour is to use reverse DNS queries. If you want to  send queries to a dns server you can use `-R` to query dns for offile hosts. For specific servers use `--dns-servers 10.10.10.10`

## Null Scan
- `sudo` permissions
- All six flag bits are set to zero. 
- This will not trigger a response when it reaches an open port. 
- Cannot differentiate between open and blocked by firewall.
- `RST` if closed port

```sh
nmap -sN 10.10.10.10
```

## TCP Scans
Advanced port scanning techniques

### FIN Scan
- Send a TCP packet with the `FIN` flag set. 
- No response if TCP port is open
- Unsure if open or blocked by firewall
```sh
nmap -sF 10.10.10.10
```

### Xmas Scan
- Sets the `FIN`, `PSH`, and `URG` flags
- `RST` means port is closed
```sh
sudo nmap -sX 10.10.10.10
```

### TCP ACK Scan
- Helpful if firewall is in front of target
```sh
sudo nmap -sA 10.10.10.10
```

### Window Scan
Scans the TCP window field of the `RST` packet.
```sh
sudo nmap -sW 10.10.10.10
```

### Custom Scan
For a custom scan you can set the flags manually.
```sh
nmap --scanflags RSTSYNFIN
```

## Spoofing
- Replies to the probe will be sent to the spoofed address therefore you must monitor the network traffic to see the response.
```sh
nmap -e NETWORK_INTERFACE -Pn -S SPOOFED_ADDR TARGET_ADDR
```

If you are on the same subnet you can spoof the MAC address as well
```sh
nmap --spoof-mac SPOOFED_MAC
```
 
## Decoys
Spoofing may prove to be difficult in most scenarios, therefore decoys might be a better approach.
```sh
nmap -D DECOY0, ATTACKER, DECOY1, DECOY2
```
 
## Fragmented Packets
| Option | Description |
| ------ | ----------- |
| `-f` | Fragmented into 8 bytes or less |
| `-ff` | Fragmented into 16 bytes or less |
| `--mtu` | Change the default value |
| `--data-length` | Append bytes to packets |

## ZOMBIES!
Zombie or idle scans require an idle device connected to the network that you can communicate with. Nmap will make packets appear to come from the idle host and then monitor the traffic to see if the zombie received responses.

1. Trigger idle host to respond so you can record the IP ID 
2. Send a `SYN` packet to a TCP port on the target with the spoofed address of the zombie.
3. Trigger idle machine again to respond so you can compare the IP IDs

```sh
nmap -sI ZOMIBE_IP
```

## Service Detection
Using `-sV` will complete the 3-way handshake to determine the version. We can determine the level of detection using:

| Option | Description 
| ------ | ----------- |
| `--version-intensity 1-9` | Lower numbers are faster but less accurate. Default = 7 |
| `--version-intensity-all` | Try every single probe|
| `--version-trace` | Output debugging information |
| `-O` | Detect OS |

### OS Detection
```sh
nmap -sS -O 10.10.10.10
```

### Traceroute
If you'd like to map out the routers in the network
```sh
sudo nmap -sS --traceroute 10.10.10.10
```

## Scripting
NSE is a scripting engine based on LUA interpreter.

View all the scripts:
```sh
ls /usr/shar/nmap/scripts
```

| Category | Description |
| -------- | ----------- |
| `auth` | Authentication related |
| `broadcast` | Send broadcast messages |
| `brute` | login brute force auditing |
| `default` | Default scripts `sC` |
| `discovery` | Retrieve accessible information (db, dns, etc)
| `dos` | Denial of Service vulnerabilites |
| `exploit` | Attempt to exploit vulnerabilities |
| `external` | Check using a 3rd party service |
| `fuzzer` | Launch fuzzing attacks |
| `intrusive` | Brute force & exploitation |
| `malware` | Backdoor scans |
| `safe` | Won't crash target |
| `version` | Service versions |
| `vuln` | Check or exploit vulnerable services |

Specify script:
```sh
sudo nmap -sS -n --script "SCRIPT NAME" 
sudo nmap -sS -n --script "ftp*"
```
