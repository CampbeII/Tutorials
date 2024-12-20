# Zeek
Zeek has two primary layers: Event Engine and Policy Script Interpreter.

Event Engine -  Where packets are processed
Policy Script Interpreter - Semantic analysis is conducted.

Default log path
```sh
/opt/zeek/logs/
```

Zeek Service:
```sh
sudo su

zeekctl
[ZeekControl] > start
starting zeek ...

[ZeekControl] > status

[ZeekControl] > stop
```

## PCAP Processing
| Parameter | Description |
| --------- | ----------- |
| `-r` | Read a pcap |
| `-C` | Ignore checksum |
| `-v` | Version information |
| `zeekctl` | ZeekControl module |
```sh
zeek -C -r sample.pcap
ls 

conn.log
dhcp.log
dns.log
packet_filter.log
```

## Logging
| Category | Description | Log Files |
| -------- | ----------- | --- ----- |
| Network | Network protocol logs | conn.log, dce-rpc.log, dhcp.log, dnp3.log, dns.log, ftp.log, http.log, irc.log, kerberos.log, modbus.log, modbus_register_change.log, mysql.log, ntlm.log, ntp.log, radius.log, rdp.log, frb.log, sip.log, smb_cmd.log, smb_files.log, smb_mapping.log, smtp.log, snmp.log, socks.log, ssh.log,ssl.log, syslog.log, tunnel.log |
| Files | File analysis log results | files.log, ocsp.log, pe.log, x509.log | 
| NetControl | Network control logs | netcontrol.log, netcontrol_drop.log, netcontrol_shunt.log, netcontrol_catch_release.log, openflow.log |
| Detection | Detection and possible indicator logs | intel.log, notice.log, notice_alarm.log, signatures.log, traceroute.log |
| Network Observations | Network flow logs | known_certs.log, known_hosts.log, known_modbus.log, known_services.log, software.log |
| Misc | External alerts, inputs, and failures | barnyard2.log, dpd.log, unified2.log, unkown_protocols.log, weird.log, weird_stats.log |
| Zeek Diagnostic | System messages, actions, stats | broker.log, capture_loss.log, cluster.log, config.log, loaded_scripts.log, packet_filter.log, print.log, prof.log, reporter.log, stats.log, stderr.log, stdout.log | 

### Common Logs
| Update Frequency | Log Name | Description | 
| ------ --------- | --- ---- | ----------- | 
| Daily | known_hosts.log | Hosts completed TCP handshakes |
| Daily | known_services.log | Services used by hosts |
| Daily | known_certs.log | List of SSL certs |
| Daily | software.log | Software used on the network | 
| Per Session | notice.log | Anomalies |
| Per Session | intel.log | Traffic contains malicious patterns | 
| Per Session | signatures.log | Triggered signatures | 

### Log Usages
| Overall Info | Protocol Based | Detection | Observation |
| ------------ | -------------- | --------- | ----------- |
| conn.log | http.log | notice.log | known_host.log |
| files.log | dns.log | signatures.log | known_services.log |
| intel.log | ftp.log | pe.log | software.log |
| loaded_scripts.log | ssh.log | traceroute.log | weird.log |

### Parsing Logs
Hostname:
```sh
cat dhcp.log | zeek-cut host_name
```

Unique DNS queries
```sh
cat dns.log | zeek-cut query | uniq
```

Longest Connection
```sh
cat conn.log | zeek-cut duration | sort -n
```


