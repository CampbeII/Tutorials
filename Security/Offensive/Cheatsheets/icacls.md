# ICACLS Cheatsheet 
Displays or modifies discrentionary access control lists (DACLs) on specified files, and applies stored DACLs to files in specified directories.
[MS Documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls)

## Basic Permissions: 

| Option | Description |
| ------ | ----------- |
| `F` | Full access |
| `M` | Modify access |
| `RX` | Read, Execute |
| `R` | Read-only access |
| `W` | Write-only access |

## Advanced Permissions;

| Option | Description |
| ------ | ----------- |
| `D` | Delete |
| `RC` | Read, Control |
| `WDAC` | Write DAC (change permissions) |
| `WO` | Write owner (take ownership) |
| `S` | Synchronize |
| `AS` | Access system secruity |
| `MA` | Maximum allowed |
| `GR` | Generic Read |
| `GW` | Generic Write |
| `GE` | General Execute |
| `GA` | Generic All |
| `RD` | Read data / list directory |
| `WD` | Write datta / add file |
| `AD` | Append data / add sub directory |
| `REA` | Read extended attributes |
| `WEA` | Write extended attributes |
| `X` | Execute / traverse | 
| `DC` | Delete child |
| `WA` | Write attributes |

## Inheritance (preceeds permissions):

| Option | Description |
| ------ | ----------- |
| `I` | ACE inherited from the parent container |
| `OI` | Object inherit ACE. (directory only) |
| `CI` | Container inherit ACE. (directory only) |
| `IO` | Inherit only. ACE inherited from parent container but does not apply to object (dir only) |
| `NP` | No propagate. Does not inherit to nested containers (dir only) |

