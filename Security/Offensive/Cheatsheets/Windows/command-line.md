# Prompt Information
Note that prompts can be run as a regular user or an admin user.

## Get Help
`commad /?` - Command help. 

## System  Information
`systeminfo` - All system info.

`doskey /history` - show history.

## User Information
`echo %username%` - View loggen in user name.

`whami /all` - all user information.

`net user administration` - account information.

## Files
`type` - show file.

`dir /s` - Searches folders.

`dir /a` - List all files (hidden too).

## Searching
`findstr` - find string.

## Processes
`tasklist /SVC | findstr flag` - running processes. The svc allows for more information.

`Get-Service | findstr flag` - Powershell alternative to tasklist.

## Networking
`ipconfig` - View network addressing and info.
`netstat -an` - Displays TC/IP connections and protocol stats.
