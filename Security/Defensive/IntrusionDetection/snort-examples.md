# Example cases

## 1. Detect all TCP port 80 traffic
```sh
alert tcp any 80 <> any any (msg:"block all port 80";sid:1000001;rev:1;)
sudo snort -c local.rules -r file.pcap -l .
```

## 2. FTP Login Attempts
```sh
alert tcp any 21 <> any any (msg:"Failed ftp logins";content:"530";sid:1000001;rev:1)
sudo snort -c local.rules -r file.pcap -l .
```

## 2. Mulitple Matches
Find case-insensitive attempts for Username:Administrator and no password.
```sh
alert tcp any 21 <> any any (msg:"Failed ftp logins";content:"331",content:"Administrator",nocase;sid:1000001;rev:1)
sudo snort -c local.rules -r file.pcap -l .
```

## 4. Torrent Files
```sh
alert tcp any any <> any any (msg:"Torrent";content:".torrent";sid:1000001;rev:1)
sudo snort -c local.rules -r file.pcap -l .
```

## 3. Blocking
```sh
snort -c /etc/snort/snort.conf -q -Q --daq afpacket -i eth0:eth1 -A full -l .
```

