# Enumeration 

## WinPEAS
Will enumerate the target system to uncover privilege escalation paths.
```sh
winpeas.exe > result.txt
```

## PrivescCheck
Similar to WinPEAS without the execution of a binary file. Maybe need to bypass execution policy
```sh
Set-ExcecutionPolicy Bypass -Scope process -Force
. .\PrivescCheck.ps1
Invoke-PrivescCheck
```

## WES-NG: Windows Exploit Suggester - Next Generation
Unlike the above 2 tools. WES-NG can be run remotely from an attacking machine. This will help prevent AV detection.
[documentation](https://github.com/bitsadmin/wesng)

```sh
wes.py systeminfo.txt
```

## Metasploit
If you have a metepreter shell on the target you can use:
```sh
multi/recon/local_exploit_suggester
```

