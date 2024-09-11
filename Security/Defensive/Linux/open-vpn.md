# Standard VPN
Configuration file: `/etc/openvpn/server/server.conf`
Restart: `sudo systemctl restart openvpn-server@server.service`

## Common Practices
1. Strong encryption:
Use the cipher directive in the configuration file to specify the encryption type.

2. Update VPN software
```sh
sudo apt upgrade openvpn
```

3. Strong authentication
Use the `auth` directive to specify the hashing algorithm.

4. Change default settings
Ensure you change all default account information

5. Enable Perfect Forward Secrecy (PFS)
- generates unique keys for each session
- use the `tls-crypt` directive. A key is required `sudo openvpn --genkey --secret my.key`


