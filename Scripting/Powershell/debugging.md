# Debugging

## Set-PSDebug
- turns debugging features on / off
- `-Trace 1` each line of the script is traced.
- `-Trace 2` variable assignments, function calls, and script calls also traced.
- `-Step` - Prompts before each line runs

## Set-StrictMode
-Generates terminating errors based on best practices.


## Breakpoints
- Set on a line of a script
- Will pause execution
- Allows you to examine the current state 

| Breakpoint | Purpose | 
| ---------- | ------- |
| `-Variable` | pauses when the variable changes |
| `-Command` | pauses when a function, parameter, or command is called |

### How to set a breakpoint
```sh
# Set on a variable
Set-PSBreakpoint -Script test.ps1 -Variable test

# Set on a line
Set-PSBreakpoint -Script test.ps1 -Line 5

# Set on a function
Set-PSBreakpoint -Script test.ps1 -Command 'Test-Cmd'

# Set breakpoint on all write functions
Set-PSBreakpoint -Script test.ps1 -Command 'Write*'

# Set based on variable value
Set-PSBreakpoint -Script test.ps1 -Command 'Write*' -Action { if ($var -eq 2) { break }}

# Set based on multiple lines
Set-PSBreakpoint -Script test.ps1 -Line 1,5,6 -Column 2
```

## Tracing Data

| Command | Purpose |
| ------- | ------- |
| Get-TraceSource | List available components to trace |
| Set-TraceSource | Assign a trace to the global scope |
| Trace-Command | Trace a specific script block |

```sh
# Start Trace
Set-TraceSource -Name "ParameterBinding" -Option ExecutionFlow -PSHost -ListenerOtpion "ProcessId, TimeStamp"

# End Trace
Set-TraceSource -Name "ParameterBinding" -RemoveListener "Host"
```

- `-Name` to specify the source
- `-Option` to select the ExecutionFlow
- `-PSHost` to send the output to console.
- `-ListenerOption` adds the `ProcessID` and `TimeStamp`
