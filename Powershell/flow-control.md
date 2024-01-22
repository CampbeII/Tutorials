# Flow Control 

## Loops

### While Loop
Tests for a `$true` condition first, then runs code

```sh
$i = 10
while ($i--) {
    write-host $i
}

$j = 0
while ($j -lt 10) {
    write-host $j
    $j++
}
```

### Do While Loop
Run once and then test for a `$true` condition.

```sh
$i = 1
do {
    write-host "Starting the loop"
    $i++
}
while ($i -lt 5)
```

### Do Until
Run once then test for a `$false` condition

```sh
$i = 5
do {
    write-host "start the loop"
    $i++
}
until ($i -lt 10) 
```

### For
Run loop a specified amount of times. Increment first.

```sh
for($i = 0; $i -lt 5; $i++) {
    write-host $i
}
```

### Foreach
Runs code for each item in the collection / array.

```sh
$users = @("john", "jane", "jake")
foreach ($user in $users) {
    write-host $user
}
```

## Decisions

### If / Elseif / Else
Runs the first code block with a `$true` condition.

```sh
$name = "Jane"
if ($name -eq "John") {
    write-host "Hi $name"
}
elseif ($name -eq "Jake") {
    write-host "Ugh, $name"
}
else {
   write-host "You are clearly not Jake or John" 
}
```

### Switch
Runs all code blocks with a `$true` condition.

```sh
switch($name) {

    # Basic
    "john" {
        write-host "Hi John"
    }
    "jane" {
        write-host "Hi Jane"    
    }

    # Supports conditions inside
    {$name.startsWith("J")} {
        write-host "name starts with a J"
    }

    # Can access with $_
    {$_ -eq "Jake"} {
        write-host "Hello Jake"
    }
}
```

## Keywords
| Keyword | Description |
|---------|-------------|
| Break | Exit loop or switch |
| Continue | Go to top of loop or switch |
| Return | Exit nearest function, script block, or script scope |

