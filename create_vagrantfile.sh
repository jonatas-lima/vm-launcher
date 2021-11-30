#!/bin/bash

HOSTNAME=$1
IP=$2
NETWORK_INTERFACE=$3
MEMORY=$4
CPUS=$5

mkdir -p ./vms/$HOSTNAME

echo "
Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.hostname = '$HOSTNAME'
  config.vm.network 'public_network', ip: '$IP', bridge: '$NETWORK_INTERFACE'
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = $MEMORY
    vb.cpus = $CPUS
    vb.name = '$HOSTNAME'
  end
  config.vm.provision 'shell', path: '../../initial_machine_setup.sh'
end
" > ./vms/$HOSTNAME/Vagrantfile