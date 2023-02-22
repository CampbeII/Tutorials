# SMTP Enumeration
- Simple Mail Transfer Protocol
- port 25
- used to send an relay outgoing emails

1. Recon the target
- nmap may not give all information
- The smtp command is not available on default kali, but does offer additional information. 
- Use nc and the help command to see more information

```sh
nmap 192.168.1.1 --script=smtp* -p 25
smtp-user-enum -H VRFY -U users.txt -t 192.168.1.1
nc -C 192.168.1.1 25 
> HELP
```

2. Run the exploit
When you have determined the server information you can then search for a relevant exploit.
- This can be done using metasploit and the `search` command


