# Static Application Security Testing
The use of automated tools for code analysis

| Pros | Cons |
| ---- | ---- |
| Doesn't require application running | Source code may not be available |
| Great coverage | false positives |
| Fast | Misses dynamic vulns |
| Reports line number | Language specific |
| Easy to integrate into CI/CD | |

## How does it work?
1. Transform the code into an abstract model
- Code is translated to AST (Abstract Syntax Tree) . 
- AST allows an analyst to read multiple languages.

2. Analyse AST

## Analyzing AST

1. Semantic
Scan the code base for instances of vulnerable functions.

2. Dataflow
Context is important. A function may not initially look vulnerable, but you need to trace the sequence of calls to get a definitive result.

3. Control flow
Searches for race conditions, uninitialized variables, or resource leaks. The following piece of code will throw an exception if `cmd` is not defined.
```java
String cmd = System.getProperty('cmd')
cmd = cmd.trim()
```

4. Structural
Analyses the specific code structures of a language and ensures it follows best practices. 
- Insecure crypto
- Dead code

5. Configuration
Searches application configuration files for vulnerabilities.

 
