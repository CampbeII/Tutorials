# NFS Enumeration
Enumerating the Network file system.

## 1. Get Services
Use rcpinfo to determine the services running
```sh
rcpinfo -p 192.168.1.1
```

## 2. Get Shares
Use showmount to list which directories you have access to mount.
```sh
showmount -e 192.168.1.1
```

## 3. Mount Share
Create a directory on your device and mount the remote share.
```sh
mkdir /mnt/nfs
mount -t nfs 10.10.10.10:sharename /mnt/nfs
cd /mnt/nfs
```
