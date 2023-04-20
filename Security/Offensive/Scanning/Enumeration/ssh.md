# Secure Shell (SSH)
- Port 22
- Asymmetric encryption uses key pairs (public / private)
`-N` - Does not show the login prompt

 
## Files
SSH Keys are typically stored in a user's home directory.'
- /home/user/.ssh/id_rsa
- /home/user/.ssh/id_rsa.pub
- /home/user/.ssh/authorized_keys

## Restricted Shdll
You can avoid shell restrictions by specifying the type of shell when logging in:

`-t` - Specify the type of shell

'ssh admin@10.10.10.10 -t sh'

You can send individual commands:

`ssh root@10.10.10.10 cat /etc/passwd`


## Remote Port Forwarding
```sh
ssh -R remote_port:localhostlocal_port:
ssh_server_hostname
```



# Local Port Forwarding
The syntax for local port forwarding with SSH is:

```sh
ssh -L local_port:dest_server_ip:remote_port ssh_user@ssh_hostname
ssh -L 1234:11.11.11.11:80 root@10.10.10.10
```


## Scan host
`nmap 10.10.10.10 -sV -p22

## Brute Force SSH
`hydra -l root -P passwords.txt 10.10.10.10 ssh`

## Log in
ssh root@10.10.10.10

## Map Network
Map out the other devices on the network by checking the arp cache.

```sh
arp -e 

Addres          HWtype  HWaddresss
10.10.10.11     ether   b8:f8:53:24:e7:60
11.11.11.11     ether   f8:b8:23:50:f2:10
```

Scan the discovered host with `nmap` to view open ports. As an example, we will assume port 80 is open.

## Accessing another subnet with port forwarding
Use local port forwading to forward the remote ip to local port 1234. 

```sh
ssh -L 1234:11.11.11.11:80 root@10.10.10.10
```

Access http://localhost:1234 to access this internal service running on port 80


# Dynamic Port Forwarding
View the configuration file for proxy chains, and take note of the addressing:

```sh
cat /etc/proxychainss4.conf
#
[ProxyList]
#
socks4 127.0.0.1 9050
```

Attempt to login:
```sh
sudo ssh -N -D 127.0.0.1:9050 root@10.10.10.10 
```

In another terminal windows lets checkout what the proxy chains output looks like.
```sh
proxychains curl -v http://11.11.11.11
```
