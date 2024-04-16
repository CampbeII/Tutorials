# Powershell Enumeration

## All Users
- `Get-LocalUser`
- `Get-ADUser -Filter *`
- `wmic useraccount get domain,name,sid`

## Current User
`wmic useraccount where name='%username%' get domain,name,sid`

## Specific user:
`wmic useraccount where name='username' get sid`

## Local Groups
`Get-LocalGroup`

## IP Address
`Get-NetIPAddress`

## Ports
`Get-NetTcpConnection`

## Patches
`wmic qfe list`
`get-hotfix`

## Find File
`Get-ChildItem -Path "C:\" -File -Include "*password*" -ErrorAction SilentlyContinue -Recurse -Force`

## Find String In File
`findstr /s "API_KEY" C:\*`

## Processes
`Get-Process`

## Scheduled Tasks
`Get-ScheduledTask`

## Get Owner of resource
`Get-Acl`

## Test Network Connection
`Test-NetConnection localhost -Port 130`

## LDAP Hierarchical Tree Structure
```
    DC=teamname,DC=com
       |           |
    CN=Users    OU=TestUnit
       |           |        |
    CN=User1    CN=User2    CN=Admins
```
You can filter searches using the following:

`Get-AdUser -Filter * -SearchBase "CN=Users,DC=teamname,DC=com"`

## Anti Virus
Enumerate AV software:
`wmic /namespace:\\root\securitycenter2 path antivirusproduct`
`Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct`

## Windows Defender
`Get-Service WinDefend`

Check the status of defender real time protection.
`Get-MpComputerStatus | select RealTimeProtectionEnabled

## Host Based Firewall
Get the status of the host based firewall
`Get-NetFirewallProfile | Format-Table Name, Enabled`

Check Firewall Rules:
`Get-NetFirewallRule | Select DisplayName, Enabled, Description`

To disable the firewall:
`Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False`

Test Firewall:
`Test-Connection -ComputerName 10.10.10.10 -Port 80`

Connect:
`(New-Object System.Net.Sockets.TcpClient("10.10.10.10", "80")).Connected`

## MS Defender
`Get-MpThreat`

## Sysmon
The following cmdlets can be used to detect sysmon agent.

```
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon"}
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'"
Get-Service | Where-Object {$_.DisplayName -like "*sysm*"}
reg query
```

## Event Log
List available event logs to gain insight into what applications and services are installed.

`Get-EventLog -List`

## Installed Applications & Processes

List applications and version:
`wmic product get name, version`

List all running services:
`net start`

Retrieve service details:
`wmic service where "name like 'SEARCH STRING'" get Name, PathName`

Process information:
`Get-Process -Name SERVICENAME`

List the listening ports:
```
netstat -noa | findstr "LISTENING" | findstr "<PORT IDENTIFIED ABOVE>"
```

## DNS Zone Transfer
The following commands will performa a DNS zone transfer to retrieve additional DNS information.

```
nslookup.exe
> server 10.10.10.10
ls -d domain.com
```

