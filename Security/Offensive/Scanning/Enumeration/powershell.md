# Powershell Enumeration

## All Users
```ps
Get-LocalUser
Get-ADUser -Filter *
wmic useraccount get domain,name,sid
```

## Current User
```ps
wmic useraccount where name='%username%' get domain,name,sid
```

## Specific user:
```ps
wmic useraccount where name='username' get sid
```

## Local Groups
```ps
Get-LocalGroup
```

## IP Address
```ps
Get-NetIPAddress
```

## Ports
```ps
Get-NetTcpConnection
```

## Patches
```ps
wmic qfe list
get-hotfix
```

## Find File
```ps
Get-ChildItem -Path "C:\" -File -Include "*password*" -ErrorAction SilentlyContinue -Recurse -Force`
```

## Find String In File
```ps
findstr /s "API_KEY" C:\*
```

## Processes
```ps
Get-Process
```

## Scheduled Tasks
```ps
Get-ScheduledTask
```

## Get Owner of resource
```ps
Get-Acl
```

## Test Network Connection
```ps
Test-NetConnection localhost -Port 130
```

## LDAP Hierarchical Tree Structure
```ps
    DC=teamname,DC=com
       |           |
    CN=Users    OU=TestUnit
       |           |        |
    CN=User1    CN=User2    CN=Admins
```
You can filter searches using the following:

```ps
Get-AdUser -Filter * -SearchBase "CN=Users,DC=teamname,DC=com"
```

## Anti Virus
Enumerate AV software:
```ps
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
wmic /namespace:\\root\securitycenter2 path antivirusproduct
```


## Windows Defender
```ps
Get-Service WinDefend
```

Check the status of defender real time protection.
```ps
Get-MpComputerStatus | select RealTimeProtectionEnabled
```

## Host Based Firewall
Get the status of the host based firewall
```ps
Get-NetFirewallProfile | Format-Table Name, Enabled
```

Check Firewall Rules:
```ps
Get-NetFirewallRule | Select DisplayName, Enabled, Description
```

To disable the firewall:
```ps
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
```

Test Firewall:
```ps
Test-Connection -ComputerName 10.10.10.10 -Port 80
```

Connect:
```ps
(New-Object System.Net.Sockets.TcpClient("10.10.10.10", "80")).Connected
```

## MS Defender
```ps
Get-MpThreat
```

## Sysmon
The following cmdlets can be used to detect sysmon agent.
```ps
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon"}
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'"
Get-Service | Where-Object {$_.DisplayName -like "*sysm*"}
reg query
```

## Event Log
List available event logs to gain insight into what applications and services are installed.
```ps
Get-EventLog -List
```

## Installed Applications & Processes

List applications and version:
```ps
wmic product get name, version
```

List all running services:
```ps
net start
```

Retrieve service details:
```ps
wmic service where "name like 'SEARCH STRING'" get Name, PathName
```

Process information:
```ps
Get-Process -Name SERVICENAME
```

List the listening ports:
```ps
netstat -noa | findstr "LISTENING" | findstr "<PORT IDENTIFIED ABOVE>"
```

## DNS Zone Transfer
The following commands will performa a DNS zone transfer to retrieve additional DNS information.
```ps
nslookup.exe
> server 10.10.10.10
ls -d domain.com
```

