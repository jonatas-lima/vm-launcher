#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt install wget curl iperf3 git

# Iniciando o servidor iperf em modo daemon
iperf3 -s -D

bash './install_and_config_zabbix.sh'