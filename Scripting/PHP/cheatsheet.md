# PHP Cheatsheet

## Comments
```php
// Single Line comment
# Another single line

/*
Multi line comment
*/

## Variables
```php
$string_var = (string) "test";
$int_var = (int) 5;
$post_var = $_POST;
$my_array = [];
```

## Arrays
```php
$array_0 = [1,2,3];
$array_1 = array("one", "two", "three");

// First Value
echo $array_0[0];

// Last Value
echo $array_0[-1];
```

## Loops
```php
for ($i = 0; $i < $array_0.length; $i++) {
    echo $array_0[$i];
}

foreach ($array_0 as $num) {
    print_r($num);
}

// Reverse Loops are fast
$count = 5;
while ($count--) {
    echo $count;
}
```

## Conditions
```php
$age = 90;

if (isset($var)) {
    // The value is set
}

if (empty($var)) {
    // the value is 0, '', or not set
}

if ($age > 420) {
    echo "That's a high number!";
}
else if ($age > 100) {
    echo "Almost there";
else {
    echo "Not high enough!";
}

// Switch Statement
switch ($colour) {
    case "red": 
        echo "colour is red";
        break;
    case "green": 
        echo "colour is green";
        break;
    default:
        echo "blue it is";
}

// Shorthand
$is_on = true;
$status = $is_on ? 'The light is on' : 'The light is off';

$fire = $is_on ?? false;
```

## Functions
```php
/**
* Say Hello
*
* @param string $name - The name to greet.
*
* @returns string - Greeting.

function say_hello(string $name):string {
    echo "Hello $name!";
}
```

## Classes
Create a file called User.php

```sh
namespace MyProject;

class User {

    public string $first_name;
    public int $age;

    function __construct(string $first_name, int $age)
    {
        $this->first_name = $first_name;
        $this->age = $age;
        $this->dog_years = $age * 7;
    }

    functionn dog_years(): void
    {
        print "You are $this->dog_years in dog years";
    }
}

$User = new User('John', 55);
$User->dog_years();

//Output
You are 385 in dog years
```

## Debugging
```php
// print strings and numbers
print $var

// print arrays
print_r($my_array);

// Show the type
var_dump($type_check);
```

## Concatenation
```php
$first = "john";
$last = "smith";
$address "123 street";

$details = $first . " $last, ";
$details .= $address;

echo $details;

// John Smith, 123 street
```

