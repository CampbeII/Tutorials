# Network Management

## Window Defender Firewall
Access by runing `WF.msc` in the run menu.

Three main profiles you can configure:

1. Domain
2. Public
3. Private
- profile must be activated with "blocked incoming connections"

- use default settings
- configure with a 'default deny' before adding an exception.

## Disable SMB protocol
```pwsh
Disable-WindowsOptionalFeature -Online -FeatureName SMBProtocol
```

## Protecting Local DNS
The hosts file acts as a "local dns" if an attacker can edit this file they can reroute traffic to their servers.
```pwsh
C:\Windows\System32\Drivers\etc\hosts
```

## Mitigating ARP Attacks
Address resolution protocol resolves MAC addresses from addresses saved in the workstation cache. ARP offers no authentication and accepts responses from any user in the network.

An attacker can flood a target system with crafted responses to place themselves in the middle of communications. 

Check the cache:
```sh
arp -a

Interface: 10.10.10.10 --- 0x5
    Internet Address    Physical Address    Type
    10.10.10.10         ff-ff-ff-ff-ff-ff   static
    22.22.22.22         01-00-5e-00-00-02   static

```

Clear the cache:
```sh
arp -d
```

## Preventing remote access
Disable remote access by going into `Settings > Remote Desktop`
