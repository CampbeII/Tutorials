# Zeek Examples
The following are example investigations you may encounter.

## 1. Anomalous DNS
We can find the number of DNS records linked to an ipv6 address by looking at the `AAAA` record.
```sh
cat dns.log | zeek-cut qtype_name | grep "AAAA" | wc -l
```

Longest connection duration:
```sh
cat conn.log | zeek-cut duration | sort -n | tail -n 1
```

Unique domain queries:
`-f` - Field list
`rev` - Reverse characters (to get the last 2)

```sh
cat dns.log | zeek-cut query | rev | cut -d '.' -f 1-2 | rev | sort -n | uniq
```

Large amount of queries sent from single ip:
```sh
cat conn.log | zeek-cut id.orig_h | sort -n | uniq -c
```

## 2. Log4j

Suspicous source
```sh
cat conn.log | zeek-cut id.resp_h | sort -n | uniq -c
```

Get File extension
```sh
cat http.log | zeek-cut uri | sort -n | uniq
```

Decode commands

