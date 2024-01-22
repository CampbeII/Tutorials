# Powershell Functions

## Comment Based Help

By structuring your comments you can provide users access to help functions

- Place before function or as the first line
- View with Get-Help
- Supports Show-Window

```sh
<#
.SYNOPSIS
Welcome the user.

.DESCRIPTION
Outputs a personalized welcome message to a user.

.PARAMETER name
The user name

.PARAMETER message
Message to send user

.EXAMPLE
PS> .\Welcome-User.ps1 -name "John" -message "How are you today?"
```

## Naming Conventions
Name you functions using a Verb-Noun format.  

- Easy to remember 
- Easy to understand it's purpose

Get-User
^      ^
Verb  Noun

```sh
function Welcome-User {
}
```

## Function Parameters
Parameters are used to pass values to the function code. 

- Place inside function, at the top
- They can be strongly typed using `[type]`
- Can be made mandatory or added to the pipeline `[Parameter(Mandatory, ValueFromPipeline)]`

```sh
    param(
        [Parameter(Mandatory)]
        [string] $name,
        [string] $message
    )
```

Calling the function with a parameter can be done two different ways:

1. Using the named parameter

```sh
PS> .\Welcome-User.ps1 -name "John" -message "How are you today?"
Welcome John! How are you today?
```

2. Default position

```sh
PS> .\Welcome-User.ps1 "John" "How are you today?"
Welcome John! How are you today?
```


## Function code
You can place code anywhere after the `param()`. For further functionality you can use the `begin{}`, `process{}`, and `end{}` code blocks.


### Begin
This optional code block will run once per function call. You can use it to perform any pre-processing steps.

### Process
This is where the work is performed. There are 2 different approaches available:

```sh
function Pick-Colour {
    param(
        [Parameter(ValueFromPipeline)]
        [string] $colour
    )
    begin {
        write-host "the function has started"
    }
    process {
        write-host "You've chosen $colour'"
    }
    end {
        write-host "the function has ended"
    }
}
```

The code will only run once when using a single parameter.

```sh
PS> Pick-Colour -colour 'red'

the function has started
You've chosen red
the function has ended

PS> Pick-Colour -colour 'red' 'green' 'blue'

ERROR
```

It will act differently when using pipeline input and will run FOREACH value passed to the function.

```sh
PS> 'red' | Pick-Colour

the function has started
You've chosen red
the function has ended

PS> 'red' 'blue' 'green' | Pick-Colour

the function has started
You've chosen red
You've chosen blue
You've chosen green
the function has ended
```

If we want our function to accept multiple values from parameters and the pipeline we need to make a few adjustments.

1. Allow the colour parameter to accept an arry `[string[]]`
2. Add a `foreach` inside our `process` block.

```sh
```sh
function Pick-Colour {
    param(
        [Parameter(ValueFromPipeline)]
        [string[]] $colours
    )
    begin {
        write-host "the function has started"
    }
    process {
        foreach ($colour in $colours) {
            write-host "You've chosen $colour'"
        }
    }
    end {
        write-host "the function has ended"
    }
}
```

### End
Like the begin block this code is optional and will only run once per function call. This is where you would clean up or close any open connections.

## Function Aliases
Add an alias to a function by placing it before the `param()` statement.

```sh
function Test-Alias {
    [alias('ta')]
    param(
        $one,
        $two
    )
}
