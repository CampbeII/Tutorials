# Scanning Websites

## 1. Find Open Ports
Save the results to a file
```sh
nmap -A $target > nmap.txt
```

## 2. Directory Enumeration
Save a list of directories and files.
```sh
gobuster dir -u "$target" -w wordlist.txt > gobuster.results
dirsearch -u "$target" > dirsearch.results
```

## 3. Retrieve interesting pages
Some interesting files to save

```sh
curl "$target/sitemap.xml" -O
curl "$target/robots.txt" -O
curl "$target/.htaccess" -O
curl "$target/manifest.json" -O
```

## 4. Pretend to be a user
Open up your web browser and explore the site as a regular user. Your goal is to find areas of the site that can be compromised.
- Read all pages
- Make a user account
- What can a user do?

## 5. Save Pages
Access the site programatically and save all the interesting pages and cookies
```sh
curl -sL --cookie-jar cookie "$target" -O
curl -sL --cookie-jar cookie "$target" -o custom_results.txt
```

## 6. Injections Test

### SQL
Authentication Bypass
Using the following test to prove if a webform is vulnerable to an authentication bypass:
[Wordlist](../Exploitation/SQL/authentication-bypass.md)
[Automated Tool](../Scanning/Tools/SQLi/authentication-bypass.sh)

### XSS

### Server-Side Template Injection (SSTI)

Success if `49` output.
```sh
{{7*7}}
```


