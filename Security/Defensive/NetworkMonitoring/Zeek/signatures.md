# Zeek Signatures

| Signature ID | Conditions | Action |
| ------------ | ---------- | ------ |
| Unique signature name | Header: Filtering packet headers for a specific source & destination address, protocol and port 
Content: Filtering the packet payload for specific value / pattern | Default action: create the signatures.log
Additional action: trigger a zeek script |

| Condition Field | Available Filters |
| --------------- | ----------------- |
| Header | 
src-ip: source ip
dst-ip: destination ip
src-port: Source port
dst-port: destination port
ip-proto: TCP, UDP, ICMP, ICMP6, IP, IP6 |
| Content | 
payload: packet payload
http-request: decoded http requests
http-request-header: client-side http headers
http-request-body: client-side http request bodies
http-reply-header: server-side http headers
http-reply-body: server-side http request bodies
ftp: command line input of ftp sessions |
| Context | same-ip: filtering the source and destination addresses for duplication |
| Action | event: signature matach message |
| Comparison | ==, !=, <, <=, >, >= |
| NOTE! | Filters accept string, numeric and regex values. |

## Signatures

### HTTP ClearText
Detect clear text passwords:
```sh
signature http-password {
    ip-proto == tcp
    dst-port == 80
    payload /.*password.*/
    event "Cleartext password found!"
}
```

Usage:
```sh
zeek -C -r sample.pcap -s sample.sig

cat signatures.log | zeek-cut src_addr dest_addr sig_id event_msg
cat signatures.log | zeek-cut sub_msg

cat notice.log | zeek-cut id.orig_h id.resp_h msg
cat notice.log | zeek-cut sub
```

### FTP Brute force
```sh
zeek -C -r ftp.pcap -s ftp-brute.sig

cat signatures.log | zeek-cut src_addr dst_addr event_msg sub_msg | sort -r | uniq
```

```sh
signature ftp-username {
    ip-proto == tcp
    ftp /.*USER.*/
    event "FTP Username Input Found!"
}

signature ftp-brute {
    ip-proto == tcp
    payload /. *530.*Login.*incorrect.*/
    event "FTP Brute-force Attempt"
}
```
