#!/bin/bash

for vm in vms/*
do
  echo $vm
  cd ./$vm && vagrant destroy -f && cd ../../ && rm -rf $vm
done