# File Transfer Protocol
Transfer files from one host to anothher
- port 21
- clear text
- anon log in
- commonly used on webservers to upload files.
- ascii transfers text file
- best to use binary mode

## Default Admin Credentials
Go for the easy win and try 

```
username: admin
password: password
```
## Basic Commands

`help` - Help

`get` - Download a file 

`put` - Upload a file 

`pwd` - Present working directory

### Modes
Used when downloading files, set these by typing them in the prompt:

`ascii` - Default. Only use for downloading text files

`binary` - Use for everything other than text files

## Anonymous Login
Try to get in anonymously
Note: Some servers parse the password to ensure it looks like an email address.

```
$ ftp 192.168.1.100 21
Connected to 192.168.1.100
220 Microsoft FTP Service
Name (192.168.1.100): anonymous
Password(192.168.1.100): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password: a@b.c
230 Anonymous user logged in.
Remote system type is Windows_NT
ftp>
```

## Brute force 
Brute force an account using hydra

```sh
hydra -l admin -P password-list.lst 192.168.1.1 ftp
```


