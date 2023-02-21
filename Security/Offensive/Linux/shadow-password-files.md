# Linux User Information
You can find information about 1 or more users by gaining access to the following files:

## /etc/passwd
View user account information such as id, groups, home directory and shell. 
- The 'x' is a placeholder for the password. Password information is stored in the shadow file.
- The default shell is /bin/bash

```sh
username:x:userID:groupID:userDescription:userHomeDirectory:userShell
campbell:x:1001:1001::/home/campbell:/bin/bash
```



## /etc/shadow
Secure user information.

```sh
username:password:lastPasswordChange:MinDaysPasswordChange:MaxDaysPasswordChange:WarnDays:ExpiryDays:
campbell:$1$fnnfffc$pGteyHdicpGOfffXXpow#5:13064:0:99999:7:::
```

The password is formatted as $id$salt$hashed. The $id can be one of the following algorithms:

`$1$` - MD5

`$2a$` - Blowfish

`$2y$` - Blowfish

`$5$` - SHA-256

`$6$` - SHA-512
