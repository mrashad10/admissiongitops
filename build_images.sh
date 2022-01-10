#!/usr/bin/env bash


cd api
# ver=$(git describe --tags)
docker build -t admissionapi:latest .
cd -


cd db
# ver=$(git describe --tags)
docker build -t admissiondb:latest .
cd -
