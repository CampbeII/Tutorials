# Linux User Information
You can find information about 1 or more users by gaining access to the following files:

## /etc/passwd
View user account information such as id, groups, home directory and shell. 
- The 'x' is a placeholder for the password. Password information is stored in the shadow file.
- The default shell is /bin/bash
- UserIDs >= 1000 are user accounts

```sh
username:x:userID:groupID:userDescription:userHomeDirectory:userShell
campbell:x:1001:1001::/home/campbell:/bin/bash
```

## Use AWK to get a list of users
- Pattern followed by an action 
- Action statements are wrapped in `{}`

```sh
awk -F: '$3 >= 1000 {print}' /etc/passwd
```
`-F` - Field separator character. Splits the input on the character you choose.
`$3` - This is field reference. Consider it like an index starting at 1.


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
