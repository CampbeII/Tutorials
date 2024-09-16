#!/usr/bin/env bash
endpoint=''
password=''
username='admin'
while IFS='' read password 
do
    encoded=$("$username:$password" | base64)
    response=$(curl -s -L -H "Authorization: Basic $endoded")
done < passwords.txt
