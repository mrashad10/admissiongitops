#!/usr/bin/env bash

function containerRestart {
    badContainer=$(docker ps|grep admission_$1|grep -v "$1:latest"|cut -d' ' -f1)
    if [ "$badContainer" != '' ];then
        docker stop $badContainer
    fi
}

git submodule update --remote

docker build -t admissionapi:latest api
docker build -t admissiondb:latest db

stackStatus=$(docker stack ls |grep admission|wc -l)
if [ $stackStatus == 0 ];then
    docker stack deploy -c docker-compose.yml admission
else
    containerRestart "api"
    containerRestart "db"
fi