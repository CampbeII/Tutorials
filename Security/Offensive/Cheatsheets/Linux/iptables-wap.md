# IPTables Wireless AP
Turn any computer into a wireless AP.

1. Install Hostapd
```
sudo apt-get install hostapd dnsmasq
```

2. Create & edit configuration file
```
zcat /usr/share/doc/hostapd/examples/hostapd.conf.gz | sudo tee -a /etc/hostapd/hostapd.conf
```

3. Edit network interfaces
```
auto lo
iface lo inet loopback

auto wlan0
iface wlan0 inet static
hostapd /etc/hostapd/hostapd.conf
address 10.10.10.10
netmask 255.255.255.0
```

4. Set a DNS relay and DHCP server 
Configure the wlan0 interface so the clients get a working internet connection. `/etc/dnsmasq.conf`
```
interface=lo,wlan0
no-dhcp-interface=lo
dhcp-range=10.10.10.10,11.11.11.11,255.255.255.0,12h
```

Make sure that linux kernel forwards traffic from our wireless network onto other destination networks. This can be found at `/etc/sysctl.conf`

```
net.ipv4.ip_forward=1
```
We need to activate NAT in the built-in firewall of Linux to make sure traffic going out uses the external address as it's source address and thus can be routed back. `/etc/rc.local`:
```
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 ! -d 192.168.1.0/24 -j MASQUERADE
```

Some WLAN cards might have a virtual switch
```
rfkill unblock 0
```

You may have to alter `/etc/NetworkManager/NetworkManager.conf`
```
[main]
plugins=ifupdown,keyfile,ofono
dns=dnsmasq

[ifupdown]
managed=false
```



```
sudo iptables -t nat -F
sudo iptables -F
sudo iptables -t net -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```
