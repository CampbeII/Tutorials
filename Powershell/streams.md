# Streams
Powershell uses 6 streams to separate different categories of data.  

| # | Stream | Write Cmdlet | Purpose |
| - | ------ | ------------ | ------- |
| 1 | Success | `write-output` | Successful results. Connected to `stdout` |
| 2 | Error | `write-error` | Terminating errors. Added to `$Error` variable. Connected to `stderr` |
| 3 | Warning | `write-warning` | Less severe non-terminating errors. |
| 4 | Verbose | `write-verbose` | Troubleshooting messages. Hidden by default unless `-Verbose` switch is set |
| 5 | Debug | `write-debug` | Developer messages. hidden by default unless `-Debug` switch is set |
| 6 | Information | `write-information` | intended to provide messages to help a user what a script is doing. `write-host` writes to information stream and the console |

## Stream Redirection
Streams can be redirected to other streams or files.

| Operator | Description |
| -------- | ----------- |
| `>` | Send stream to file |
| `>>` | Append stream to file | 
| `>&1` | Redirect to success stream |
| `>&2` | Redirect to error stream |

## Errors
Errors are split into 2 catergories

1. Design Time Errors
- Syntax errors
- No exception object created
- Code unable to execute

2. Runtime Errors
- Occur during execution
- Creates an exception object in the `$Error` variable


## Working with Errors
`-ErrorAction` - flag can be used to suppress or catch errors.
`$?` - Boolean Status of last command run
`$LastExitCode` - Exit code of last command run
`$Error` - Array containing all errors in session.
`-ErrorVariable` - Custom variable to hold errors.
`write-error` - creates a non-terminating error as well as stores the information in `Error`

## Error Handling
`throw` will generate a terminating error with a custom message.

```sh
function Test-Error {
    'This line will execute normally'
    throw 'This is a custom error'
    'This line will not execute'
}

Test-Error
This line will execute normally

This is a custom error
At line:3 char:5
+ Throw "This is a custom error"
+ CategoryInfo : OperationStopped: (This is a custom error:String) [], RuntimeException
+ FullyQualifiedErrorId: This is a custom error
```

### Trap

- Runs when a terminating error occurs
- Will handle all exception types by default
- Can handle specific exception types
- Multiple `trap{}` blocks can be defined

You can specify how trap behaves using keywords

- the default is to display the error message and then continue running the code
- `Break` - Show error; stop code execution
- `Continue` - Hide error; continue code

```sh
trap [system.management.automation.commandnotfoundexception] {
    write-host 'Trapped!'
    continue
}
write-host 'this code should run'
Fake-Command

Trapped!
this code should run
```

### Try / Catch / Finally

`try{}` - Will contain the code to check for errors
`catch{}` - Executes code if error occurs
`finaly{}` - Will always run regardless of error

```sh
try {
    Fake-Command
}
catch [system.management.automation.commandnotfoundexception] {
    'Caught!'
}
finally {
    'this will always run'
}

Caught!
this will always run
```
