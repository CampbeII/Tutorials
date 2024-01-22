# Function Parameters
Parameters are passed to the function using this basic syntax

```sh
function Test-Params {
    param(
        $one,
        $two
    )
}
```

Parameter attributes add additional functionality or information to parameters.

| Attribute | Type | Purpose |
| --------- | ---- | ------- |
| Mandatory | Bool | Will error if variable is not set |
| Position | Int | Position of expected paremeter |
| ParameterSetName | String | Think of this like a group. Default is "All" |
| ValueFromPipeline | Bool | Can the value be sent via the pipeline |
| ValueFromPipelineByPropertyName | Bool | Is a property name required via the pipeline |
| ValueFromRemainingArguments | Bool | Store extra arguments |
| HelpMessage | String | A help message for the user |

## Alias Attribute
Give your parameters (and functions) aliases so that they are easier to remember. 

```sh
function Test-Alias {
    param(
        [Parameter()]
        [Alias('name')]
        [string] $ComputerName
    )
}

PS> Test-Alias -name 'TestComputerName'
```

## Excess Positional Values

- Allows a SINGLE parameter to accept overflow parameters
- Converts parameter to type of `[array]`
- Forces the paremeter to be in the last position

By default if you pass too many parameters to a function you will receive an error.

```sh
function Test-RemainingArguments {
    param(
        $name,
        $location
    )
}


PS> Test-RemainingArguments 'Alex' 'Atlanta' 'US'

Test-RemainingArguments: A positional parameter cannot be found that accepts argument 'US'
```

Add the excess arguments to the location parameter:

```sh
function Test-RemainingArguments {
    param(
        $name,
        [Parameter(ValueFromRemainingArguments)]
        $location
    )
}

PS> Test-RemainingArguments 'Alex' 'Atlanta' 'US'

name: Alex
location: Atlanta US
```

## Parameter Validation Attributes

- validates before executing code
- returns an error when invalid

| Attribute | Purpose |
| --------- | ------- | 
| ValidateCount(int min, int max) | Min / Max number of arguments for a cmdlet parameter |
| ValidateLength(int min, int max) | Min / Max characters for a parameter |
| ValidatePattern(string regex) | Parameter matches a regular expression |
| ValidateRange(object min, object max) | Min / Max values for parameter |
| ValidateScript(scriptblock script) | Custom code to validate parameter |
| ValidateSet("john", "jane") | Validate against a set of values |
