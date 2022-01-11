#!/usr/bin/env bash


function echoGreen {
    echo -e "\e[32m$1\e[0m"
}

function echoRed {
    echo -e "\e[31m$1\e[0m"
}


# Send the validation fail request
echo -ne "Validation Test\t"
error=$(curl -s 'http://localhost:3001/' -H 'Content-Type: application/json' -X POST -d '{"username":"ABC 1"}')
if [ "$error" == '{"success":false,"errors":[{"value":"ABC 1","msg":"Invalid value","param":"username","location":"body"}]}' ];then
    echoGreen "success"
else
    echoRed "fail"
    exit 1
fi

# Send the success request
echo -ne "Valid insert\t"
valid=$(curl -s 'http://localhost:3001/' -H 'Content-Type: application/json' -X POST -d '{"username":"ABC"}')
# Read the key to use in query
key=$(echo $valid|jq .key)

if [ "$key" != "" ];then
    echoGreen "success"
else
    echoRed "fail"
    exit 1
fi



# Check if the record inserted
echo -ne "Record inserted\t"
count=$(docker exec $(docker ps -q -f name=admission_db) sqlite3 /volume/messages.db "select count(*) from messages where key = $key")
if [ "$count" == 1 ];then
    echoGreen "success"
else
    echoRed "fail"
    exit 1
fi