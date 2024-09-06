# RPC
When an RPC service is started it tells rpcbind the address at which it is listening and the RPC program number it is prepared to serve.

Enumerate an RPC file service:
```sh
nmap 10.10.10.10 -p 111 --script=nfs,ls,nfs-statfs,nfs-showmount
```
