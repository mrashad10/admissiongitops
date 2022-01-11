#!/usr/bin/env bash


git submodule update --remote

docker build -t admissionapi:latest api
docker build -t admissiondb:latest db

docker stack deploy -c docker-compose.yml admission

docker service update --force admission_db
docker service update --force admission_api