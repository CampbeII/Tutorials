# Developing Advanced Functions

1. Create a basic function called `write-message` that takes 2 parameters `message` and `colour` and writes a message to the screen.
```powershell
function write-message {
    param(
        [string] $colour,
        [string] $message
    )

    write-host $message -ForegroundColor $colour
}
```

2. For a function to be "advanced" it must used the `[cmdletbinding()]` above the `param()` statement. This will add the common parameters `-verbose` and `-debug`. Write to the verbose, error, and information streams.
```powershell
function write-message 
{
    [cmdletbinding()]
    param(
        [string] $colour,
        [string] $message
    )

    # Is shown when the -verbose flag is set
    write-verbose "This is a verbose message"


    # Will show when the -debug flag is set
    write-information "This is information"


    # Always written to console
    write-host $message -ForegroundColor $colour

    # Always written to console, but can be suppressed using -ErrorAction SilentlyContinue or terminated with Stop
    write-Error "Custom error"
}
```

3. Risk mitigation is a feature of advanced functions. Create a function that reads from a csv file and creates a new AD user. The csv file should have one column named "name"

```powershell
function New-User 
{
    [cmdletbinding()]
    param(
        [string] $csv
    )
    $users = Import-Csv $csv
    foreach ($user in $users) {
        $user | New-ADUser
        write-verbose "Added user: $($user.name)"
    }
}
```

4. Add 2 other functions `get-users` and `remove-users`  that list all active directory users and remove users respectively. This will help us debug and cleanup later.
```powershell
function get-users 
{
    param(
        [int] $hours = 6
    )
    $created = (Get-Date).AddHours(-$hours)
    Get-Aduser -filter { whencreated -gt $created } | select Name
}

function remove-users 
{
    param(
        [int] $hours = 6
    )
    $created = (Get-Date).AddHours(-$hours)
    Get-Aduser -filter { whencreated -gt $created } | remove-aduser -confirm:$false -verbose
}
```

5. We want to ensure we don't add duplicate users. Add a `New-AccountName` function to check for an existing user before adding them to AD
```powershell
function New-AccountName
{
    param(
        [string] $name
    )
    if ([bool] (Get-ADUser -filter {SamAccountName -eq $name} | Select name)) {
        write-host "$name already exists."
    }
    else {
        write-host "$name is unique"
    }
}
```

6. If we find a duplicate name we will want to append a variable to it to make it unique. A `while` loop allows us to keep checking names.
```powershell
function New-AccountName
{
    param(
        [string] $name
    )
    $unique = $name
    $count = 0
    while ([bool] (Get-ADUser -filter {SamAccountName -eq $unique})) {
        $unique = $name + $count
        $count++
    }
    if ($unique -ne $name) {
        write-warning "$name already exists, using $unique instead"
    }
    $unique
}
```

7. Call the `New-AccountName` function from the `New-User` function to ensure that a unique name is generated.
```powershell
function New-User 
{
    [cmdletbinding()]
    param(
        [string] $csv
    )
    $users = Import-Csv $csv
    foreach ($user in $users) {
        $user.name = New-AccountName -name $user.name
        $user | New-ADUser
        write-verbose "Added user: $($user.name)"
    }
}
```

8. Add `SupportsShouldProcess` into the `[cmdletbinding()]` to enable risk mitigation. We want to suppress the risk mitigation for `New-AdUser` so that it won't endlessly run in our loop.'
```powershell
function New-User 
{
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [string] $csv
    )
    $users = Import-Csv $csv
    foreach ($user in $users) {
        $user.name = New-AccountName -name $user.name
        $user | New-ADUser -Confirm:$false
        write-verbose "Added user: $($user.name)"
    }
}
```

9. Add an if statement inside the foreach loop surrounding the code that requires confirmation. This will make sure nothing runs without approval.
```powershell
function New-User 
{
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [string] $csv
    )
    $users = Import-Csv $csv
    foreach ($user in $users) {
        $user.name = New-AccountName -name $user.name
        if ($PSCmdlet.ShouldProcess($user.name, "Adding user")) {
            $user | New-ADUser -Confirm:$false
            write-verbose "Added user: $($user.name)"
        }
    }
}
```
