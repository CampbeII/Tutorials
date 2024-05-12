# Hash Tables
- Holds other objects providing constant search time.
- Uses a selected key to find a selected value.
- Created with @{}
- Useful for creating custom objects.

```sh
$Person = @{
    Name = "John"
    Age = 44
    City = "Atlanta"
}

PS> $Person["Name"]
John

PS> $Person.Name
John

PS> $Person.Score = 20
Name    Value
----    -----
Name    John
Age     44
City    Atlanta
Score   20
```

A custom object can give you access to some built in functions. To define a custom object:

```sh
$Person = [pscustomobject] @{
    Name = "Jane"
    Age = 42
    City = Mexico
    Score = 40
}
```
