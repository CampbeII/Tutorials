# File Transfer Protocol
Transfer files from one host to anothher
- port 21
- clear text
- anon log in
- commonly used on webservers to upload files.
- ascii transfers text file
- best to use binary mode

## Brute force Anonymous user 
If you cannot get the files you want as an anon user, you can try to brute force using hydra.
```sh
hydra -l admin -P password-list.lst 192.168.1.1 ftp
```


