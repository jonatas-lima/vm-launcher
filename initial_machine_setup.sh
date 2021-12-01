#!/bin/bash

GIT_BRANCH=master

sudo apt update && sudo apt upgrade -y && sudo apt install -y wget curl iperf3 git

# Iniciando o servidor iperf em modo daemon
iperf3 -s -D

git clone https://github.com/jonatas-lima/vm-config -b $GIT_BRANCH && cd vm-config

bash './launch_zabbix_agent.sh'
bash './launch_mysql_container.sh'