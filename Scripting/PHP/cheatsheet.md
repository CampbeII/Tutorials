# PHP Cheatsheet

## Comments
```php
// Single Line comment
# Another single line

/*
Multi line comment
*/
```

## Variables
```php
$string_var = (string) "test";
$int_var = (int) 5;

# Global
$post_var = $_POST['input_field_name'];
$get_var = $_GET['url_parameter'];
$ip_address = $_SERVER['REQU
```

## Arrays
```php
$array_0 = [1,2,3];
$array_1 = array("one", "two", "three");
$assoc_array = [
    "name" => "john",
    "age" => 90,
];


# First Value
echo $array_0[0];

# Last Value
echo $array_0[-1];

# Deconstruct
list($a, $b, $c) = $array_0;
# $a = 1
# $b = 2
# $c = 3

# Associative Arrays
list('name' => $a, 'age" => $b) = $assoc_array;
# $a = 'john'
# $b = 90

# Shorthand
[$a, $b, $c] = $array_0;
['name' => $a, 'age" => $b] = $assoc_array;

# Skip elements
[, , $c] = $array_0;
# $c = 3

# Null Coalescing
$a = ['name' => 'john'];
$b = $a['name'] ?? 'Please enter name';
```

## Loops
```php
for ($i = 0; $i < count($array_0); $i++) {
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


# Null Coalescing
$a = null;
$b = $a ?? 'fallback';
$b = isset($a) ? $a : 'fallback';

# Ternary
$b = $a ?: 'fallback';
```

## Functions
```php
/**
* Say Hello
*
* @param string $name - The name to greet.
*
* @returns string - Greeting.

function say_hello(string $name = 'john'):string {
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
    public bool $is_happy;
    public string|int|array $possible;

    private User&Player $intersection;

    function __construct(string $first_name, int $age)
    {
        $this->first_name = $first_name;
        $this->age = $age;
        $this->dog_years = $age * 7;
    }

    functionn get_dog_years(): void
    {
        print "You are $this->dog_years in dog years";
    }

    function possible(string|int|array $var): string|int|array
    {
        return $var;
    }

    function intersections(User&Player $scope): User&Player
    {
        return $scope;
    }
}

class Player extends User
{
}

$John = new User('John', 55);
$John->is_happy = true;
$John->get_dog_years(); // You are 385 in dog years
```

## Debugging
```php
// print strings and numbers
print $var;
echo $var;

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
