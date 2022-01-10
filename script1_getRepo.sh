#!/usr/bin/env bash

git clone --recurse-submodules https://github.com/mrashad10/-admissiongitops.git gitOps
cd gitOps
git submodules update --remote
./script2_build_images.sh

docker stack deploy -c docker-compose.yml admission