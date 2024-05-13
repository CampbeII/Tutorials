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
$array_1 = ["one", "two", "three"];

$assoc_array = [
    "name" => "john",
    "age" => 90,
];

# First Value
echo $array_0[0];

# Last Value
echo $array_0[-1];

# Skip elements
[, , $c] = $array_0; // $c = 3
```

### Deconstructing Arrays
```php
list($a, $b, $c) = $array_0; 
[$a, $b, $c] = $array_0;

// $a = 1 $b = 2 $c = 3

# Associative Arrays
list('name' => $a, 'age" => $b) = $assoc_array;
['name' => $a, 'age" => $b] = $assoc_array;

// $a = 'john' $b = 90
```

### Unpacking Arrays
```php
$result = ['zero', ...$array_1, 'four'] // ['zero', 'one', 'two', 'three', 'four']

# Associative Arrays
$assoc_array_1 = [
    "colour" => "green",
];

$result = [
    ...$assoc_array_0,
    'colour' => 'green',
];
```

## Loops
```php
for ($i = 0; $i < count($array_0); $i++) {
    echo $array_0[$i];
}

foreach ($array_0 as $num) {
    echo $num;
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

function say_hello(string $name = 'john'):string 
{
    echo "Hello $name!";
}

/**
* Variadic functions 
- Pass a variable number of parameters
- Must be the end
*/
function variadic_func(string $param, string ...$options)
{
    return count($options);
}

variadic_funct('test0', 'one'); // 0
variadic_funct('test1', 'one', 'two', 'three'); // 2

# UnPacking
function unpacker(int $a, int $b, int $c): int
{
    return $a + $b + $c;
}

$array = [2,3,4,5];
$result = unpacker(1, ...$array); // a = 1 + b = 2 + c = 3
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

# New class
$John = new User('John', 55);

# Set variable
$John->is_happy = true;

# Call function
$John->get_dog_years(); // You are 385 in dog years

# Nullsafe
$John?->is_happy

# Named Parameters
class User {
    public function __construct( public string $name, public int $age)
    {
        // $this->name = $name is not needed in this case
    }
}
$John = new User(name: "john", age: 90);
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

## Enums
```php
enum Status {
    case HIGH;
    case MEDIUM;
    case LOW;
}
if ($var === Status::HIGH) {
 // High sev
}
```
