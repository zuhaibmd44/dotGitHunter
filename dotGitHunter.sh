#!/bin/bash
#Zuhaib Mohammed - July 2021
#This script is used to identify open .git directory for a list of subdomains
#Command to run -> ./dotgitFinder.sh subdomains.txt
subDomains="$1"
while IFS= read -r line
do
    http_response=$(curl -L --insecure -s -o response.txt -w "%{response_code}" $line/.git)
    http_title=$(cat response.txt | grep "<title>.*</title>" | sed -e 's/<[^>]*>//g' | awk '{$1=$1};1')
    echo $line/.git":--:"$http_response":--:"$http_title
done < "$subDomains"
