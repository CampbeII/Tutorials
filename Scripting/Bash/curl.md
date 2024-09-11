# Curl 

Headers
```sh
curl -I 
curl -I $url | grep -i "Content-Length"
```

Send & Update Cookies:
```sh
curl --cookie cookie.txt --cookie-jar cookie.txt
```
