1. Create an new script called `Pet.ps1` and define a class named "pet"
```sh
class Pet {
    
}
```

2. Add properties for `name` and `species`
```sh
class Pet {
    $name
    $species
}
```

3. Call the class by using the static method, and then assign the properties values
```sh
$Dog = [Pet]::new()
$Dog.name = 'Dave'
$Dog.species = 'Dog'

name species
---- ------
Dave Dog
```

4. Inspect the object with `$Dog | Get-Member`. 
```sh
$Dog | Get-Member

Name      MemberType  Definition
----      ----------- ----------
name      Property     System.Object name {get;set;}
speciies  Property     System.Object speciies {get;set;}
```

5.  You should see a type of `System.Object`. This is the default type assigned to properties. Change the type to `[string]` and test again
```sh
class Pet {
    [string] $name
    [string] $species
}

$Dog = [Pet]::new()
$Dog | Get-Member

Name      MemberType  Definition
----      ----------- ----------
name      Property     string name {get;set;}
speciies  Property     string speciies {get;set;}
```

6. Add a method `DoTrick()` and invoke it. By default a method will have a type of `[void]`. You can confirm this with `Get-Member`
```sh
class Pet {
    [string] $name
    [string] $species

    DoTrick()
    {
        write-host "Barrel Roll!"
    }

}

$Dog = [Pet]::new()
$Dog | Get-Member

Name      MemberType  Definition
----      ----------- ----------
DoTrick   Property     void DoTrick()

```

8. Change `DoTrick()` to `return` a string. You can confirm this with `Get-Member`
```sh
class Pet {
    [string] $name
    [string] $species

    [string] DoTrick()
    {
        return "Barrel Roll!"
    }

}

$Dog = [Pet]::new()
$Dog | Get-Member

Name      MemberType  Definition
----      ----------- ----------
DoTrick   Property     string DoTrick()
```

9. Methods can also take parameters when they are placed inside the `()`. Alter `DoTrick()` to include a name.
```sh
class Pet {
    [string] $name
    [string] $species

    [string] DoTrick([string] $name)
    {
        return "$name did a barrel roll!"
    }
}

$Dog = [Pet]::new()
$Dog.DoTrick('Dave')

Dave did a Barrel Roll!
```


10. Overloads are methods with the same name, but unique parameters. Overload `DoTrick()` so that it will run when no values are added and when you specify a name.
```sh
class Pet {
    [string] $name
    [string] $species

    [void] DoTrick()
    {
        write-host "Play dead"
    }

    [void] DoTrick([string] $name)
    {
        write-host "$name did a barrel roll!"
    }

}

$Dog = [Pet]::new()
$Dog.DoTrick()

Played Dead

$Dog.DoTrick('Dave')

Dave did a barrel roll!
```

11. `$this` represents the current class. We can use it to access class properties and methods. Modify the `DoTrick()` so that it calls the overloaded method and provides it a name.
```sh
class Pet {
    [string] $name
    [string] $species

    [void] DoTrick()
    {
        write-host this.DoTrick('Dave')
    }

    [void] DoTrick([string] $name)
    {
        write-host "$name did a barrel roll!"
    }

}

$Dog = [Pet]::new()
$Dog.DoTrick()

Dave did a barrel roll!

$Dog = [Pet]::new()
$Dog.DoTrick('Phteven')

Phteven did a barrel roll!
```

12. `Constructors` are used to pass custom values during object creation. 
- Create a constructor by adding a method with the same name as the class
- Overloading allowed, but MUST have unique arguments.
- Calling a constructor without the parenthesis `[Pet]::new`  will output the OverloadDefinitions
- Constructors always return an object with the `type` of the class `[Pet]`

```sh
class Pet {
    [string] $name
    [string] $species

    # This constructor adds a default name of "Fluffy"
    Pet () 
    {
        $this.name = 'Fluffy'
    }

    # This constructor allows us to specify values when we call it
    Pet ([string] $name, [string] $species) 
    {
        $this.name = $name
        $this.species = $species
    }

    [void] DoTrick()
    {
        write-host "$($this.name) did a barrel roll!"
    }

}

# No Parameters
$Dog = [Pet]::new()
$Dog.name 

Fluffy

# With Parameters
$Dog = [Pet]::new('Dave', 'Dog')
Dog

name species
---- -------
Dave Dog
```

13. We want to restrict the value of species to a select number of species. This is done by `Enums {}`
```sh
enum Species {
    Dog
    Cat
    Reptile
}
class Pet {
    [string] $name
    [species] $species
}

# Test Enums
[species] "Dog"
[species] 1
[species] "ERROR"
```

14. Create a new class that inherits the `Pet` class
```sh
enum Species {
    Dog
    Cat
    Reptile
}
class Pet {
    [string] $name
    [species] $species

    # This constructor adds a default name of "Fluffy"
    Pet () 
    {
        $this.name = 'Fluffy'
    }

    # This constructor allows us to specify values when we call it
    Pet ([string] $name, [string] $species) 
    {
        $this.name = $name
        $this.species = $species
    }

    [void] DoTrick()
    {
        write-host "$($this.name) did a barrel roll!"
    }

}
class Dog : Pet {
    
}

# Confirm the new class has all the base methods
$dog = [dog]::new()
$dog | get-member
```

15. Constructors will not be inherited. Create a new constructor in the `dog` class and set the `species` property of the base class to be `dog`. 
```sh
class Dog : Pet {
    Dog ()
    {
        $this.species = [species]::dog 
    }
}

[dog]::new()
```

16. Enable the use of the base class constructor by using `:base`
```sh
class Pet {
    [string] $name
    [species] $species

    Pet ([string] $name, [species] $species) 
    {
        $this.name = $name
        $this.species = $species
    }

    
}
class Dog : Pet {
    Dog ()
    {
        $this.species = [species]::dog 
    }
    Dog ($name) : base ($name, [species]::dog)
    {
        
    }
}

[dog]::new()
```

17. Overload the method `Speak()` to use a different colour.
```sh
class Pet {
    [string] $name
    [species] $species

    Pet ([string] $name, [species] $species) 
    {
        $this.name = $name
        $this.species = $species
    }

    [void] Speak([string] $message)
    {
        write-host "$message" -ForegroundColor red
    }
    
}
class Dog : Pet {
    Dog ()
    {
        $this.species = [species]::dog 
    }
    Dog ($name) : base ($name, [species]::dog)
    {
        
    }
    [void] Speak([string] $message)
    {
        write-host "$message" -ForegroundColor green
    }
    
}

$dog = [dog]::new('Dave')
$dog.Speak('Woof')

Woof
```

18. Use dot sourcing to include your class files in other scripts.

```sh
. $PSScriptRoot\Pet.ps1
```
