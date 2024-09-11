# Firewall

## Netfilter
Provides packet-filtering software for the linux kernel 2.4x.  Requires `iptables` or `nftables`

## iptables
To setup SSH use the following steps:

1. Flush old rules before creating new ones:
```sh
iptables -F
```

2. Accept incoming tcp packets to port 22
`-A INPUT` - Appends to INPUT chain
`-p tcp --dport 22` - tcp port 22
`-j ACCEPT`
```sh
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

3. Accept outgoing tcp packets to port 22
`-A OUTPUT` - Appends to OUTPUT chain
`-p tcp --dport 22` - tcp port 22
`-j ACCEPT`

4. Drop everything else
```sh
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
```

## nftables
Supported in kernel 3.13

1. Create a table
```sh
nft add table <table_name>
```

2. Add input / output chains
```sh
nft add chain <table_name> fwinput { type filter hook input priority 0\; }
nft add chain <table_name> fwoutput { type filter hook input priority 0\; }
```

3. Add Rule
```sh
nft add <table_name> fwinput tcp dport 22 accept
nft add <table_name> fwoutput tcp sport 22 accept
```

4. Check 
```sh
nft list table <table_name>
```

## UFW (Uncomplicated Firewall)
1. Allow SSH traffic
```sh
ufw allow 22/tcp
```

2. Check
```sh
ufw status
```

