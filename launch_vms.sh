#!/bin/bash

VMS_FILE='./vms.csv'

while IFS= read -r line
do
  HOSTNAME=$(echo $line | cut -d',' -f1)

  cd ./vms/$HOSTNAME && vagrant up && cd ../../
done < $VMS_FILE