#!/usr/bin/env bash


terraform apply -auto-approve -compact-warnings
ansible-playbook swarm_setup.yml