#!/bin/bash

GIT_BRANCH=testing

sudo apt update && sudo apt upgrade -y && sudo apt install -y wget curl iperf3 git

# Iniciando o servidor iperf em modo daemon
iperf3 -s -D

git clone https://github.com/jonatas-lima/zabbix-agent-config.git -b $GIT_BRANCH && cd zabbix-agent-config

bash './install_and_config_zabbix_agent.sh'
bash './launch_mysql_container.sh'