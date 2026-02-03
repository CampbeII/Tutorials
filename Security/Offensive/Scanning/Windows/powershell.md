# Powershell Enumeration

## All Users
```pwsh
Get-LocalUser
Get-ADUser -Filter *
wmic useraccount get domain,name,sid
```

## Specific User
```pwsh
wmic useraccount where name='%username%' get domain,name,sid
wmic useraccount where name='username' get sid
```

## Local Groups
```pwsh
Get-LocalGroup
```

## IP Address
```pwsh
Get-NetIPAddress
```

## Ports
```pwsh
Get-NetTcpConnection
```

## Patches
```pwsh
wmic qfe list
get-hotfix
```

## Find File
```pwsh
Get-ChildItem -Path "C:\" -File -Include "*password*" -ErrorAction SilentlyContinue -Recurse -Force
```

## Find String In File
```pwsh
findstr /s "API_KEY" C:\*
```

## Processes
```pwsh
Get-Process
```

## Scheduled Tasks
```pwsh
Get-ScheduledTask
```

## Get Owner of resource
```pwsh
Get-Acl
```

## Test Network Connection
```pwsh
Test-NetConnection localhost -Port 130
```

## LDAP Hierarchical Tree Structure
```txt
    DC=teamname,DC=com
       |           |
    CN=Users    OU=TestUnit
       |           |        |
    CN=User1    CN=User2    CN=Admins
```
You can filter searches using the following:

```pwsh
Get-AdUser -Filter * -SearchBase "CN=Users,DC=teamname,DC=com"
```

## Anti Virus
Enumerate AV software:
```pwsh
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
wmic /namespace:\\root\securitycenter2 path antivirusproduct
```


## Defender
Check the status of defender real time protection.
```pwsh
Get-MpThreat
Get-Service WinDefend
Get-MpComputerStatus | select RealTimeProtectionEnabled
```

## Host Based Firewall
Get the status of the host based firewall
```pwsh
# Status
Get-NetFirewallProfile | Format-Table Name, Enabled

# Rules
Get-NetFirewallRule | Select DisplayName, Enabled, Description

# Disable firewall
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

# Test Firewall
Test-Connection -ComputerName 10.10.10.10 -Port 80
```

## Socket Connections
```pwsh
(New-Object System.Net.Sockets.TcpClient("10.10.10.10", "80")).Connected
```

## Sysmon
The following cmdlets can be used to detect sysmon agent.
```pwsh
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon"}
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'"
Get-Service | Where-Object {$_.DisplayName -like "*sysm*"}
reg query
```

## Event Log
List available event logs to gain insight into what applications and services are installed.
```pwsh
Get-EventLog -List
```

## Installed Applications & Processes
List applications and version:
```pwsh
wmic product get name, version
```

List all running services:
```pwsh
net start
```

Retrieve service details:
```pwsh
wmic service where "name like 'SEARCH STRING'" get Name, PathName
```

Process information:
```pwsh
Get-Process -Name SERVICENAME
```

List the listening ports:
```pwsh
netstat -noa | findstr "LISTENING" | findstr "<PORT IDENTIFIED ABOVE>"
```

## DNS Zone Transfer
The following commands will perform a DNS zone transfer to retrieve additional DNS information.
```pwsh
nslookup.exe
> server 10.10.10.10
ls -d domain.com
```

