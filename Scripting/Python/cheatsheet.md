# Python Cheatsheet

## Printing
```py
print('hello World')
print(f'hello {variable}')
```

## Comments
```py
# Single line comment
"""
Multi
Line 
Comment
"""

/*
Multi
Line
Comment
*/
```

## Variables
```py
string_var = str("var")
int_var = int(30)
float_var = float(0.0)
```

## Lists (Arrays)
```py
array_0 = [1,2,3]
array_1 = ["one", "two", "three"]

# Accessing Values
echo array_0[0]

# Adding to array
array_0[0] = 4
array_0.append(4)

# Removing from array
array_0.pop(0)
array_0.remove(0)

# Last Value
echo $array_0[-1]

# Length
length = len(array_0)

# Loop
for x in array_0:
    print(x)
```

## Functions
```py
def my_function(arg1, arg2):
    print(arg1 + arg2)

my_function(10,20)

# Default values
def my_function(country="canada"):
    pass

# Named arguments
def add_user(name,age,colour):
    print(name)

add_user(age=100, name="test", colour="blue")

# Unkown amount of args
def my_function(*args):
    print(args[2])

# Unkown amount of named args
def my_function(**args):
    print(args["name"])

```
