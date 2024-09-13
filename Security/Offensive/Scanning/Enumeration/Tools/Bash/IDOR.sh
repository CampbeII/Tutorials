#!/usr/bin/env bash

# Enumerate an endpoint
# Find flag based on pattern

url='http://10.10.10.10'
limit=100
username='test'
password='test'
flag_pattern='THM\{.*\}'

login=$(curl -s -L -d "username=$username" -d "password=$password" --cookie-jar cookie.txt "url/login/")

for i in $(seq 1 $limit)
do
    req=$(curl -s -L --cookie cookie.txt "$url")
    [[ $req =~ $flag_pattern ]] && echo $BASH_REMATCH
done

