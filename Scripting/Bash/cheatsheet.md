# Bash Scripting

## Shebang
```sh
#!/usr/bin/env bash
```

## Variables
```sh
# Comments

# Variables
var1='A'
var2='B'
```

## Arrays
```sh
myArray=("cat" "dog" "lizard")

# Loop over values
for str in ${myArray[@]}; do
    echo $str
done

# Loop with Index
for i in ${!myArray[@]}; do
    echo "index: $i"
    echo "value: ${myArray[$i]}" 
done
```

## Conditions
```sh
if [ string1 == string2 ]; then
    echo "matched"
fi
```

## Functions
Bash functions return the status of the last statement in the function.

`0` - Success
`1 - 255` - Failure 

```sh
function_name () {
    #commands
}

function function_name {
    #commands
}

# Call the function
function_name
```
### Function Arguments

| Variable | Description |
| -------- | ----------- |
| `$0` | function name | 
| `$1 - $n` | Arguments | 
| `$#` | number of arguments passed | 
| `$*` `$@` | All arguments | 
| `"$*"` | "arg1 arg2 arg3" | 
| `"$@"` | "arg1" "arg2" "arg3" | 

```sh
function_name() {
    # arg1
    echo $1

    # arg2
    echo $2
}

# Call function with arguments
function_name "arg1" "arg2"
```

