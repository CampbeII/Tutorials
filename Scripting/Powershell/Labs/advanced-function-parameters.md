# Advanced Function Parameters

1. Create a new function with a mandatory parameter. A mandatory parameter will require a value or else an error is thrown.
```powershell
function Test-MandatoryFun {
    param(
        [Parameter(Mandatory)]
        [string] $name
    )
}
```

2. A `HelpMessage` can be used with `Mandatory` to provide extra information. If you do not use mandatory the help message will not show. After running the function with no parameters you will need te `?!` to view the help messag.

```powershell
function Test-MandatoryFun {
    param(
        [Parameter(Mandatory, HelpMessage ="Please provide a name")]
        [string] $name
    )
}
```

3. If we want to take multiple values from the pipeline we need make a few adjustments to our code by adding a `process{}` block.
```powershell
# Powershell function
Test-Fun {
    [cmdletBinding]
    param(
        [parameter(Mandatory, HelpMessage = "Path to csv", ValueFromPipeline)]
        [string] $csv
    )
    process {
        $users = Import-Csv $csv
        foreach ($user in $users) {
            write-host $user.Name
        }
    }
}
```

"people.csv", "people2.csv" | Test-Fun

4. Parameter sets allow a single function to expose unique parameters to the user. In the following example an error will be thrown if 
```powershell
function Test-ParamSet {
    [cmdletBinding()]
    param(
        [parameter(ParameterSetName = "Set1")]
        $a,
        [parameter(ParameterSetName = "Set2")]
        $b
    )

    write-host $PSCmdlet.ParameterSetName
}

PS> Set-1
```
