# Powershell Enumeration

## All Users
- `Get-LocalUser`
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
