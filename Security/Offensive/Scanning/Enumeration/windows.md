# Windows Enumeration

Detailed system information:
`systeminfo`

Installed updates & Patches:
`wmic qfe get Caption, Description`

Windows Services
`net start`
`sc.exe query state=all`

Installed Applications
`wmic product get name,version,vendor`

User Privileges
```
whoami /priv
whoami /groups
```

| Command | Description |
| ------- | ----------- |
| `net user` | View Users |
| `net group` | Groups on a Domain Controller |
| `net localgroup` | Available groups |
| `net localgroup administrators` | Specify group |
| `net accounts` | Local settings |
| `net accounts /domain` | Machines connected to a domain |

Networking
`ipconfig /all` - network configuration
`netstat -abno` - All ports, Binary, No resolve, output PID
`arp -a` - Discover other systems on the LAN

## Insecure Service Permissions
`D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BU)`
