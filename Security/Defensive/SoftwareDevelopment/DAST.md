# Dynamic Software Analysis
The process of testing a running instance of a web application for weaknesses and vulnerabilities. Similar to a black box attack DAST will identify vulnerabilites by trynig to exploit them.

| Pros | Cons |
| ---- | ---- |
| Finds vulnerabilities during run time | Low code coverage |
| HTTP request smuggling | Misses certain vulnerabilities |
| Cache poisioning | Difficulty crawling |
| Parameter pollution | No remediation |
| Language agnostic | Long scan time |
| Reduced fale positives | Application needs to be running |
| Business logic flaws


## Scan Types
Both processes are complimentary and you can achieve the best results by combining the two.

### Manual
A engineer performs tests against an application.
- Run periodically
- Slow methodical process
- Full blown pentest before production.

### Automatic
A tool will scan the application. 
- Fast response
- Catches low haning fruit
