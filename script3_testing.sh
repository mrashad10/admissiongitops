#!/usr/bin/env bash


# Send the success request
curl -s 'http://swarm.mrashad.com:3001/' -H 'Content-Type: application/json' -X POST -d '{"username":"ABC"}' -o /dev/null
# Send the validation fail request
curl -s 'http://swarm.mrashad.com:3001/' -H 'Content-Type: application/json' -X POST -d '{"username":"ABC 1"}' -o /dev/null


# Get the table content to validate the inserts
docker-compose exec admission_db sqlite3 /volume/messages.db 'select * from messages;'