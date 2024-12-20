# YARA Rule Development

Commands must have 2 arguments:
1. The rule file 
2. Name of file, directory, or process id the rule applies to

## Syntax
| Keyword | Description |
| ------- | ----------- |
| Desc | A short summary |
| Meta | Descriptive information |
| Strings | Matches on strings |
| Conditions | <=, >=, != | 
| Weight | Apply a weight to rule |

This simple rule will check to see if the file/directory/PID we specify exists via `condition: true`. 

```sh
rule myrulename {
    condition: true
}
```

- If the file exists we are given the output of `myrulename`.
- If the file does not, we will get an error.

## Detect strings
The following rule will check the existence of `Hello World!`

```sh
rule string_checker {
    strings:
        $hello_world = "Hello World!"
    condition:
        $hello_world
}
```

### Case-insensitive
```yaml
rule case_insensitive {
    strings:
        $hello_world = "Hello World!"
        $hello_world = "hello world!"
        $hello_world = "HELLO WORLD!"
    condition:
        any of them
}
```

### Combining Conditions

### Multiple Occurences

