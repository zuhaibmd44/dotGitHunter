#!/bin/bash
#Zuhaib Mohammed - July 2021
#This script is used to identify open .git directory for a list of subdomains
#Command to run -> ./dotGitFinder.sh subdomains.txt
#v2 - Improved the execution speed by sedning the process to background
#Install the uuid-runtime package before running the script using "apt install uuid-runtime"

function getResponse {
    uuid=$(dbus-uuidgen) #unique file identifier to store output of cURL request
    http_response=$(curl -L --insecure -s -o $uuid.txt -w "%{response_code}" $line/.git)
    http_title=$(cat $uuid.txt | grep "<title>.*</title>" | sed -e 's/<[^>]*>//g' | awk '{$1=$1};1')
    echo $line/.git":--:"$http_response":--:"$http_title
    rm $uuid.txt
}

subDomains="$1"
while IFS= read -r line
do
    getResponse "$line" & 
done < "$subDomains"
wait # wait for all child processes to finish