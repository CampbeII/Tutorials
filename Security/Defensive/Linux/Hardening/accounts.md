# Accounts & Access

## Grub Password
Boot access = root access
Note: This is not needed for cloud deployments.

We will use `grub2-mkpasswd-pbkdf2` tool to generate a hash:
```sh
grub2-mkpasswd-pbkdf2
Enter password:
Reenter password:
PBKDF2 hash of your password is
grub.pbkdf2.sha512.10000.534B77<REDACTED>
```

## Remote Password Sniffing
With any server online 24/7 we will need a strong password to prevent someone from eventually guessing it.

1. Disable root login and force non-root users
2. Force public key authentication

Note: Don't disable password login if you haven't tested the alternative!

Add the following lines to `/etc/ssh/sshd_config`:
```sh
PermitRootLogin no
PubKeyAuthentication yes
PasswordAuthentication no
```

## Securing User Accounts
Avoid logging in as root. Instead, create a new account and add them to the sudoers group.
```sh
usermod -aG sudo mynewusername
usermod -aG wheel mynewusername
```

Disable Root in `/etc/passwd`
Change `root:x:0:0:root:/root:/bin/bash` to `root:x:0:0:root:/root:/sbin/nologin`

## Enforce a Strong Password Policy
Use `libpwquality` to enforce password constraints. 

Install:
```sh
apt-get install libpam-pwquality
```

Configuration file locations: 
```sh
/etc/security/pwquality.conf
/etc/pam.d/common-password
```

### Options
`difok` - number of characters not in previous password
`minlen` - minimum length
`minclass` - min class requirement (upper/lower case, digit, etc)
`badwords` - words not allowed in password
`retry=N` - prompts user `N` amount of times

### Disable Unused Accounts
This can be done as the same way as above:
```sh
username:x:0:0:username:/home/username:/sbin/nologin
```
