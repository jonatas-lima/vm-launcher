#!/bin/bash

VMS_FILE='./vms.csv'

while IFS= read -r line
do
  HOSTNAME=$(echo $line | cut -d',' -f1)
  IP=$(echo $line | cut -d',' -f2)
  NETWORK_INTERFACE=$(echo $line | cut -d',' -f3)
  MEMORY=$(echo $line | cut -d',' -f4)
  CPUS=$(echo $line | cut -d',' -f5)

  bash './create_vagrantfile.sh' $HOSTNAME $IP $NETWORK_INTERFACE $MEMORY $CPUS
  cd ./vms/$HOSTNAME && vagrant up && cd ../../
done < $VMS_FILE