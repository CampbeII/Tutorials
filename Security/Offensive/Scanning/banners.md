# Banners
Pulling banners will provide important information about the service running

## cURL
| Switch | Description |
| ------ | ----------- |
| `-s`   | Prevent error messages |
| `-i`   | Header information |

```sh
curl -s I 10.10.10.10
```

## Wget
| Switch | Description |
| ------ | ----------- |
| `-q`   | Cover up progress |
| `-S`   | Header information |

```sh
wget -q -S 10.10.10.10
```

## Telnet
```sh
telnet 10.10.10.10 21
```

## Netcat
```sh
nc 10.10.10.10 21
```

## Nmap
| Switch | Description |
| ------ | ----------- |
| `-sV`   | Service versions |
| `-p`   | Port |

```sh
nmap -sV -p22 10.10.10.10
```

