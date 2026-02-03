# ROR13 (Rotate Right 13) 
ROR13 is a simple hashing algorithm that rotates bits right 13. The number is arbritrary. 

The following will breakdown how LoadLibraryA would look like using the ROR13 hashing algorithm.

| Character | ASCII |
| --------- | ----- |
| L |  76 |
| o | 111 |

Binary Representation:
00000000 000000000 00000000 01001100 | 76 | L |

Rotating
shift all bits 13 positions to the right. Anything that fall off will wrap around to the left.

Rightmost bits: 00000 01001100
shift everything right 13: 00000 00000000
wrap bits: 00000010 01100000 00000000 00000000


## Powershell Script
The following script will generate the hashes based on a string parameter.
```ps1
$right = $hash -shr 13 # Shift bits right
$left = $hash -shl 19 # Takes original hash and shifts left by (32 - 13 = 19) 

$bor = $right -bor $left

[uint32] $hash = ($hash -shr 13) -bor ($hash -shl 19)
```


### Full Example
```ps1
function Get-ROR13 {
    param (
        [string] $name
    )

    foreach ($char in $name.ToCharArray()) {
        # Add ASCII value to hash 
        [uint32] $hash = $hash + [byte][char]$char
        [uint32] $hash = ($hash - shr 13) -bor ($hash -shl 19)
    }
    "{0:X8}h" -f $hash
}
```
