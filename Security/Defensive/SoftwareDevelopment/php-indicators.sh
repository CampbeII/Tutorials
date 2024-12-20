#!/usr/bin/env bash

vulns=(
    'mysqli_query('
    'mysqli_prepare('
    'mysql_query('
    'query('
    'prepare('
    'require('
    'require_once('
    'include_once('
    'include('
)

for vuln in ${vulns[@]}; do
    grep -rnw . -e "$vuln" --exclude x.sh --color
done
