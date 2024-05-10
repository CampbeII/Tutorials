# Triggered Persistence

## Startup folder
Any payload placed into the following directory will be run whenever a user logs in.

```sh
c:\users\<username>\appdata\roaming\microsoft\windows\start menu\programs\startup
```

For all users:
```sh
c:\programdata\microsoft\windows\start menu\programs\startup
```

## Registry
Force a user to execute the program on log in via the registry

Current User:
```sh
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
```
Everyone:
```sh
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
```

1. Upload a reverse shell to `C:\Windows`
2. Create `REG_EXPAND_SZ` registry entry under `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
[Registry](Images/persistence-registry.png)

## WinLogon
This is the component that loads your user profile right after authentication.

Keys:
```sh
HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
```
Executables:

`Userinit` - restoring profile preferences
`shell` - system shell (explorer.exe)

We do not want to break the logon sequence so ensure to append the backdoor.
```sh
Userinit    REG_SZ  C:\windows\system32\userinit.exe, C:\shell.exe
```

## Logon Scripts
The `userinit.exe` process that is responsible for loading your user profile uses a variable called `UserInitMprLogonScript`. We can store a custom log in script here.

1. Create the environment variable under `Computer\HKEY_CURRENT_USER\Environment`
```sh
UserinitMprLogonScript      REG_EXPAND_SZ       C:\Windows\shell.exe
```



