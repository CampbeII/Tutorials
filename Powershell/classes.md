# Powershell Classes
Properties
- like variables
- strongly typed 
- `[object]` by default

Methods
- no param statement required
- must `return` to pass out data
- must strongly type to return data
- `[void]` by default
- DifferentNamingSyntax()

```sh
class Person {
    [string] $name
    [int32] $age
    [string] $city

    [string] SayHello()
    {
        return "Hello there"
    }
}

PS> $Person = [Person]::new()
PS> $Person.SayHello()

Hello there
```

## Creating an instance of a class

### New-Object
```sh
$Person = New-Object -TypeName Person
$Person.name = 'Alex'
$Person.age = 66

```

### Hash Table
```sh
$Person = [Person]@{
    name = 'Alex'
    age = 66
}
```

### Default Constructor
```sh
$Person = [Person]::new()
$Person.name = 'Alex'
$Person.age = 66
```

### Custom Constructor
A constructor is defined in the class similar to a method. 

```sh
class Person {

    [string] $name
    [int32] $age

   Person([string] $name, [int32] $age)
   {
        $this.name = $name
        $this.age = $age
   }
}

PS> $Person = [Person]::new('Alex', 66)
```

## Methods with Parameters
```sh
class Person {
    [string] $name
    [int32] $age
    [string] $city

    [string] SayHello([string] $message)
    {
        return "Hello there, $message"
    }
}

PS> $Person = [Person]::new('Alex', 66)
PS> $Person.SayHello('how are you today?')

Hello there, how are you today?
```

### Overloading a Method

- Multiple methods with the same name
- Allows for default values 

```sh
class Person {
    [string] $name
    [int32] $age
    [string] $city

    [string] SayHello([string] $message)
    {
        return "Hello there, $message"
    }

    [string] SayHello()
    {
        return "Hello there. Fine weather we are having today."
    }
}

PS> $Person.SayHello('how are you today?')
Hello there, how are you today?

PS> $Person.SayHello()
Hello there. Fine weather we are having today.
```

### Using $this
- Used to interact with class methods and variables
- Contains the instance of the object 
- overloads with the LEAST argumenst should call ones with the most arguments

```sh
class Person {
    [string] $name
    [int32] $age
    [string] $city

    [string] SayHello([string] $message)
    {
        return "Hello there, $message"
    }

    [string] SayHello()
    {
        return $this.SayHello('Fine weather we are having today.')
    }

    [void] IncrementAge([int32] $years)
    {
        $this.age += $years
    }
}
```

## Including a class inside of another script

```sh
. $PSScriptRoot\Person.ps1

$Person = [Person]::new('Alex', 66)
```

## Inheritance
- used to reuse and extend code 
- retains all properties and methods 

An example of basic inheritance:

```sh
class Person {
    [string] $name
}

class Child : Person {
    [string] $school

    Child() {
        $this.school = 'School Name'
    }

}

$Child = [Child]::new()

school name age
------ ---- --- 
test         0
```

Using constructors in inherited classes are a little more complicated. Lets say you wanted to initialize like this:

```sh
$Child = [Child]::new('Alex', 12)
```

You would need to use the `base()` statement in the second constructor

```sh
class Person {
    [string] $name
    [int] $age

    Person([string] $name, [int] $age)
    {
        $this.name = $name
        $this.age = $age
    }
}

class Child : Person {
    [string] $school

    Child([string] $name, [int] $age) : base($name, $age) {
        $this.school = 'test'
    }

}

$Child = [Child]::new('Alex', 12)

school name age
------ ---- --- 
test   Alex 12
```

## Enums

- strongly typed set of labels
- Used to specify options
- assigned integer values in the backrgound

```sh
Enum Colour {
    Red
    Blue
    Green
    Black
    White
}

function Test-Colour {
    param(
        [colour] $colour
    )
}

Test-Colour 'Yellow'

ERROR: Cannot process argument transformation on parameter 'colour' ...
```
