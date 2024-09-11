## Logs & Threat Hunting
The following files are interesting:

| Path | Description |
| ---- | ----------- |
| `/var/log/messages` | General log |
| `/var/log/auth.log` | Authentication attempts |
| `/var/log/secure` | Authentication attempts | 
| `/var/log/utmp` | Users currently logged in |
| `/var/log/wtmp` | Users currently logged in / out | 
| `/var/log/kern.log` | Messages from the kernel |
| `/var/log/boot.log` | Boot information |

Reading logs
```sh
tail -n 12 /logfile
tail -f /logfile
```
