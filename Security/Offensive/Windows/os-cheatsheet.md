# Windows
`\Program Files` - Contains programs.

`\Program Files (x86)` - Contains programs. x86 is for older 32 and 16 bit programs.

`\Users` - All system user's directories.

`\Windows` - System folders, exe, and dll files

`\Inetpub` - Default web server directory.

## Short file names
Short file names can be an alternative to character
Consider the following `dir` output

```sh
dr--r--r--  1 ftp   ftp 0   Mar 01 2000 Program Files
dr--r--r--  1 ftp   ftp 0   Mar 01 2000 Program Files (x86)
```

Take the first 6 characters of a name followed by `~` and a number
```sh
ftp> dir progra~1`
ftp> dir progra~2`
```



