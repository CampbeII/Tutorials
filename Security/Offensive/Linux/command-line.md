# Prompt Information
`#` - Root 

`$` - Regular 

## Get Help
`man nmap` - Show the nmap command documentation.

`nmap -h` - View command help.

`apropos` - Find commands using keywords.

`uname -a` - Operating system information used to determine if an exploit is available.

`file bin` - Locate help about a file.

`history` - Command history.

`whereis` - locates programs.

## User information
`whoami` - display current user information.

`id` - user and group names. Root users are 0, regular start at 1000


`sudo -l` - All root commands.

## Files
`drwxrwxrwx` - (d) directory, (r) read, (w) write, (x) execute.

`cat filename.txt` - View the contents of a file.

`strings binaryfile` - show printable characters.

`cat filename.txt | head -n 5` - show first 5 liens.

`cat filename.txt | tail -n 5` - show last 5 liens.

## Searching
`find / -name flag.txt` - Will only print what it finds.

`grep -rnw / -e 'password'` - Search line by line and match an expression.

## Processes
`ps aux` - print all running processes from all users.

`crontab` - List of scheduled jobs.
