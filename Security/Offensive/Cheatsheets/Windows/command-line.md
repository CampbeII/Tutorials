# Prompt Information
Note that prompts can be run as a regular user or an admin user.

## Get Help
`commad /?` - Command help. 

## System  Information
`systeminfo` - All system info.

`doskey /history` - show history.

## User Information
`echo %username%` - View loggen in user name.

`whoami /all` - all user information.

`net user administration` - account information.

## Files
`type` - show file.

## Searching

### Command Prompt (CMD)

#### 1. DIR
`dir [filename] /s` - Searches folders.
`dir "*filename*" /s` - Contained in filename

| CMD | Description |
| --- | ----------- |
| `/s` | Recursive Search |
| `/b` | Minimal Output |
| `/a:h` | Hidden Files |
| `/a:-d` | Exclude Directories |

#### 2. WHERE
Locate a file by name:
```sh
where /r C:\ "onedrive.exe"
```

Located multiple files:




## Find String 
`findstr` - find string.

## Processes
`tasklist /SVC | findstr flag` - running processes. The svc allows for more information.

`Get-Service | findstr flag` - Powershell alternative to tasklist.

## Networking
`ipconfig` - View network addressing and info.
`netstat -an` - Displays TC/IP connections and protocol stats.
