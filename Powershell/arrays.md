# Powershell Arrays

```sh
PS> $MyArray = 1,2,"john",0.24
PS> $MyArray = @(1,2,"john",0.24)

# Index counts from 0
PS> $MyArray[0]
1

# Negative index
PS> $MyArray[-1]
0.24

# Range of indexes
PS> $MyArray[0..2]
1
2
john

# Multiple indexes
PS> $MyArray[0,3]
1
0.24

# Functions
PS> $MyArray[2].ToUpper()
JOHN
```

## Storing values in an array using a foreach loop
```sh
$Users = ['john', 'jane', 'jake']
$Results = [system.collections.arraylist] @()
foreach ($user in $Users) {
    $Results.Add($user)
}
```
