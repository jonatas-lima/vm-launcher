#!/bin/bash

GIT_BRANCH=stack
STACK=$1

sudo apt update && sudo apt upgrade -y && sudo apt install -y wget curl git

git clone https://github.com/jonatas-lima/vm-config -b $GIT_BRANCH && chown vagrant:vagrant -R vm-config && cd vm-config

for script in stacks/$STACK/*
do
  bash $(pwd)/$script
done
