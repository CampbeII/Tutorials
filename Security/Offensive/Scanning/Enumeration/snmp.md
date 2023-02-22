# SNMP Enumeration
- Simple Network Management Protocol
- Based on UDP
- Uses community strings which may 
- can be installed on linux


## onesixtyone
Can enumerate community strings

`snmp-check` - A better alternative to `snmpwalk` to enumerate users and information

## Writing to SNMP
```sh
set OID 1.3.6.1.2.1.1.5.0
set OIDValue test
set RHOSTS 192.168.1.1
run
```
