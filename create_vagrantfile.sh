#!/bin/bash

HOSTNAME=$1
OS=$2
IP=$3
NETWORK_INTERFACE=$4
MEMORY=$5
CPUS=$6
STACK=$7
ZABBIX_SERVER_IP=$8

mkdir -p ./vms/$HOSTNAME

echo "
Vagrant.configure('2') do |config|
  config.vm.box = '$OS'
  config.vm.hostname = '$HOSTNAME'
  config.vm.network 'public_network', ip: '$IP', bridge: '$NETWORK_INTERFACE'
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = $MEMORY
    vb.cpus = $CPUS
    vb.name = '$HOSTNAME'
  end
  config.vm.provision 'shell', path: '../../initial_machine_setup.sh', args: ['$STACK', '$ZABBIX_SERVER_IP']
end
" > ./vms/$HOSTNAME/Vagrantfile