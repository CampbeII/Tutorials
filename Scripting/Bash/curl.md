# Curl 

## Headers
Check what `HEAD` says:
Note: servers respond differently to this request.
```sh
curl -I "$url"
```

### Get Request Headers:
| Option | Description |
| ------ | ----------- |
| `-D` | Dump headers to file |
| `-` | Send to stdout |
| `-o` | Ignore response body |
```sh
curl -s -D - -o /dev/null $url
```

### Set Request Headers
```sh
curl -H "Content-Type: application/json" 
```

## POST Request
```sh
curl -d "username=$username" -d "password=$password" "$url"
```

## Cookies
```sh
curl --cookie cookie.txt --cookie-jar cookie.txt
```



Output to file:
