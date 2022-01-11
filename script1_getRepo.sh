#!/usr/bin/env bash

git clone --recurse-submodules https://github.com/mrashad10/-admissiongitops.git gitOps
cd gitOps
git submodule update --remote
./script2_start_service.sh

docker stack deploy -c docker-compose.yml admission