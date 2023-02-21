# Linux Operating System CheatSheet

`/root` -  Root user's home directory.

`/bin` & `/sbin` - System binaries. View available commands.

`/etc` - System configuration files. 

## User Information
`/etc/passwd` - Account information.

**Syntax:**

`username:x:userID:groupID:userDescription:userHomeDirectory:userShell`

`campbell:x:1001:1001::/home/campbell:/bin/bash`

`/etc/shadow` - Secure information.

**Syntax:**

`username:password:lastPasswordChange:MinDaysPasswordChange:MaxDaysPasswordChange:WarnDays:ExpiryDays:`

`campbell:$1$fnnfffc$pGteyHdicpGOfffXXpow#5:13064:0:99999:7:::`

**Password format syntax:**

$id$salt$hashed - The ID is the [algorithm](algorithms.md)

`/var` - Logs

`/var/www` - Apache web server if installed.

`/usr` - User binaries & libraries.

`/home` - User`s directories.
