#!/bin/bash

VMS_FILE='./vms.csv'

while IFS= read -r line
do
  HOSTNAME=$(echo $line | cut -d',' -f1)
  OS=$(echo $line | cut -d',' -f2)
  IP=$(echo $line | cut -d',' -f3)
  NETWORK_INTERFACE=$(echo $line | cut -d',' -f4)
  MEMORY=$(echo $line | cut -d',' -f5)
  CPUS=$(echo $line | cut -d',' -f6)
  STACK=$(echo $line | cut -d',' -f7)
  ZABBIX_SERVER_IP=$(echo $line | cut -d',' -f8)

  bash './create_vagrantfile.sh' $HOSTNAME $OS $IP $NETWORK_INTERFACE $MEMORY $CPUS $STACK $ZABBIX_SERVER_IP
  cd ./vms/$HOSTNAME && vagrant up && cd ../../
done < $VMS_FILE