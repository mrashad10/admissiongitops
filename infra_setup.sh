#!/usr/bin/env bash


terraform apply -auto-approve
ansible-playbook swarm_setup.yml