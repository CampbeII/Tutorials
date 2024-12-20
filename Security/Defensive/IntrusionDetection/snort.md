# Snort
Open source intrusion detection software

| CMD | Description |
| --- | ----------- |
| `-T` | Test configuration |
| `-c` | Specify configuration (snort.conf) |

## Test configuration
```sh
snort -T -c /etc/snort/snort.conf
```

## Sniffer Mode
| CMD | Description |
| --- | ----------- |
| `-v` | TCP/IP output in console. |
| `-d` | Display packet data |
| `-e` | Display the link-layer (TCP/IP/UDP/ICMP) headers. |
| `-X` | Display full packet details in HEX |
| `-i` | Interface to sniff |

### Interface Sniffing
If you only have one interface, snort will use it by default.
```sh
sudo snort -v
sudo snort -v -i eth0
```

Dump and link-layer header grabbing mode:
```sh
sudo snort -de
```

Full packet dump mode:
```sh
sudo snort -X
```

## Logging Mode
| CMD | Descirption |
| --- | ----------- |
| `l` | Logger mode, output to `/var/log/snort` |
| `K ASCII` | Log packets in ASCII format |
| `-r` | Read dumped logs in snort |
| `-n` | Number of packets to be read |

Packet logger mode the `-l .` logs to the current directory:
```sh
sudo snort -dev -l .

snort.log.1234355
```

Read logs (will no work with ASCII):
```sh
sudo snort -r snort.log.1234355
```

Berkley Packet Filtering (BPF):
```sh
sudo snort -r logname.log -X
sudo snort -r logname.log icmp
sudo snort -r logname.log tcp
sudo snort -r logname.log 'udp and port 53'
```

## IDS/IPS Mode
| Flag | Description |
| ---- | ----------- |
| `-c` | Define configuration file |
| `-T` | Test config |
| `-N` | Disable logging |
| `-D` | Background mode |
| `-A` | Alert modes: 
| `-q` | Quiet mode, no banner |
*full*: Default mode. All output
*fast*: Alert message, time, source and dest ip, port 
*console*: Fast style alerts in console output 
*cmg*: CMG style, basic header details with payload in hex.
*none*: Disable alerting |

Blocking mode example:
```sh
snort -c /etc/snort/snort.conf -q -Q --daq afpacket - i -A full -l .
```

## PCAPs
| Flag | Description |
| ---- | ----------- |
| `-r / --pcap-single=` | Read a single pcap |
| `--pcap-list=""` | Space separated list |
| `--pcap-show` | Show pcap name in console |

Single PCAP
```sh
sudo snort -c /etc/snort/snort.conf -q -r file.pcap -A console -n 10
```

Multiple PCAPs
```sh
sudo snort -c /etc/snort/snort.conf -q --pcap-list="file1.pcap file2.pcap" -A console -n 10
```

PCAP Show
```sh
sudo snort -c /etc/snort/snort.conf -q --pcap-list="file1.pcap file2.pcap" -A console --pcap-show
```

## Rules
The anatomy of a snort rule is as follows:

| Action | Protocol | Source IP | Source Port | Direction | Destination IP | Destination Port | Options |
| ------ | -------- | ------ -- | ------ ---- | --------- | ----------- -- | ----------- ---- | ------- |
| Alert | TCP | ANY | ANY | <> | ANY | ANY | Msg |
| Drop | UDP | ANY | ANY | <> | ANY | ANY | Sid |

Rules cannot be processed without a header.

### Actions
| Action | Description |
| ------ | ----------- |
| Alert | Generate an alert and log the packet |
| Log | Log packet |
| Drop | Block and log |
| Reject | Block packet, log, and terminate |

### Protocals
Snort2 only supports:
- IP
- TCP
- UDP
- ICMP


### IP Addressing
Create an alert for each ICMP packet originating from 10.10.10.10
```sh
alert icmp 10.10.10.10 any <> any any 
```

*IP Ranges*
Create an alert for each ICMP originating from the 10.10.10.0/24 subnet.
```sh
alert icmp 10.10.10.0/24 any <> any any 
```

*Multiple IP ranges*
Create an alert for each ICMP packet originating from a subnet list.
```sh
alert [10.10.10.0/24, 11.11.11.0/24] any <> any any
```

*Exclude IP addresses / ranges*
Create an alert for each ICMP packet NOT originating from a subnet.
```sh
alert icmp !10.10.10.0/24 any <> any any
```

### Port Filtering
Create an alert for each TCP packet sent to port 21
```sh
alert tcp any any <> any 21
```

*Exclude Port*
Create an alert for each TCP packet NOT sent to port 21
```sh
alert tcp any any <> any !21
```

*Port Ranges*
Create an alert for each TCP packet sent to ports 1-1024
```sh
alert tcp any any <> any 1:1024
```

Create an alert for each TCP packet sent to ports `<=` 1024
```sh
alert tcp any any <> any :1024
```

Create an alert for each TCP packet sent to ports `>=` 1024
```sh
alert tcp any any <> any 1024:
```

Create an alert for each TCP packet sent to 21 AND 23
```sh
alert tcp any any <> any [21,23]
```

### Direction
Indicates the traffic flow.

| CMD | Description |
| --- | ----------- |
| `->` | Source to destination |
| `<>` | Bi-directional |

## Rule Options

### 1. General Options
Fundamental rule options.
| Key | Description |
| --- | ----------- |
| Msg | This will appear in the console log |
| Sid | <100: Reserved rules 
100-999999: Built-in
>=1000000: User defined |
| Reference | Helpful links / external resources |
| Rev | Revision number |

### 2. Payload Options
Rules to help investigate payload data.
| Key | Description |
| --- | ----------- |
| Content | Matches payload data by ASCII, HEX or both |
| Nocase | Disable case sensitivity | 
| Fast_pattern | Required when using multiple `content` options |

### 3. Non-Payload
Create specific patterns to identify network issues.
| Key | Description |
| --- | ----------- |
| ID | Filter the ip ID field |
| FLags | F - FIN
S - SYN
R - RST
P - PSH
A - ACK
U - URG |
| Dsize | Payload size
dsize:min<>max
dsize:>100
dsize:<100 |
| Sameip | Filter source and ip for duplication |

## Local Rules
Any rules you add should be placed in the `/etc/snort/rules/local.rules` file.

Filter by IP ID
```sh
alert tcp any any <> any any (msg:"Filter by ID";id:1234;sid:1000001;rev1;)
alert udp any any <> any any (msg:"Filter by ID";id:1234;sid:1000001;rev1;)
alert icmp any any <> any any (msg:"Filter by ID";id:1234;sid:1000001;rev1;)
```

Filter by Flag(s)
```sh
alert tcp any any <> any any (msg:"Filter SYN";flags:S;sid:1000001;rev1;)
alert tcp any any <> any any (msg:"Filter PUSH-ACK";flags:P,A;sid:1000001;rev1;)
```

Same IP
```sh
alert tcp any any <> any any (msg:"Filter duplicate ips";sameip;sid:1000001;rev1;)
alert udp any any <> any any (msg:"Filter duplicate ips";sameip;sid:1000001;rev1;)
```

Packet Size
```sh
alert tcp any any <> any any (msg"byte me"; dsize:770<>855;sid:100001;rev:1;)
```

## General Logic
Main components:
    1.Packet decoder prepares the packets for pre-processing.
    2. Pre-processors arrange and modify the packets for the detection engine.
    3. Detection engine applies the rules
    4. Logging & Alerting generate the result files
    5. Outputs & Plugins adds additional support

Three Rule Types:
    1. Community rules are free.
    2. Registered rules are free but delayed 30 days.
    3. Subscriber rules are paid and updated twice a week.

## Global Configuration

### Network Variables
| Name | Description | Example |
| ---- | ----------- | ------- |
| `HOME_NET` | What we're protecting |  `any` OR `10.10.10.0/24` |
| `EXTERNAL_NET` | External network | `any` OR `!$HOME_NET` |
| `RULE_PATH` | Hardcoded rule path | `/etc/snort/rules` |
| `SO_RULE_PATH` | Registered & Subscriber rules | `$RULE_PATH/so_rules` |
| `PREPROC_RULE_PATH` | Registered & Subscriber rules | `$RULE_PATH/so_rules` |

### Configure the Decoder
Manage the IPS. Single node installation works best with `afpacket` mode.
| Tag | Description | Example |
| --- | ----------- | ------- |
| `config daq:` | IPS mode selection | afpacket |
|`config daq_mode:` | Activate inline mode | inline |
|`config logdir:` | Default log path | `/var/logs/snort` |

Data Acquisition Models (DAQ) are used for packet I/O, brinig flexibility to process packets.
- pcap: default (sniffer)
- afpacket: inline mode (IPS)
- ipq: inline mode on linux using netfilter
- nfq: inline mode on linux
- ipfw: inline OpenBSD and FreeBSD by using divert sockets with pf and ipfw firewalls.
- dump: testing mode of inline

## Configure Output Plugins
Default action prompts everything in the console.

## Customize Ruleset
| Tag | Description | Example | 
| --- | ----------- | ------- | 
| `site specific rules` | Hardcoded and user-generated paths | include $RULE_PATH/local.rules |
| `include $RULE_PATH/` | Hardcoded rules path | include $RULE_PATH/rulename |
