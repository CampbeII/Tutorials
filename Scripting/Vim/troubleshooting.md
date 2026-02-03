# Troubleshooting
Problems i've encountered and their solutions.

## Vim is loading slow
1. Check to see if it is your profile or the filesystem by looking at the timestamps. 
```sh
vim --startuptime result.log
```

2. Check the value of the `$HOME` variable
| Where | CMD |
| ----- | --- |
| Vim | `:echo $HOME` | 
| Windows | `write-host $HOME` | 

In my case this was set to a network drive which was causing the loading issues.
