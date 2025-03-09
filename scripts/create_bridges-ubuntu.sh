#!/bin/bash

## Create Bridges
brctl addbr br-s1ap
brctl addbr br-gtpc
brctl addbr br-gtpu
brctl addbr br-diam
brctl addbr br-enb

## Enable the Bridges
ip link set br-s1ap up
ip link set br-gtpc up
ip link set br-gtpu up
ip link set br-diam up
ip link set  br-enb up

## Run the following command to install iptables-persistent, which will create the necessary directories and files for saving iptables rules
## During the installation, you will be prompted to save your current iptables rules. Select "Yes" to save them.
#sudo apt-get install iptables-persistent

##allow communiction for the clab
sudo iptables -I DOCKER-USER -i br-s1ap -j ACCEPT
sudo iptables -I DOCKER-USER -i br-gtpc -j ACCEPT
sudo iptables -I DOCKER-USER -i br-gtpu -j ACCEPT
sudo iptables -I DOCKER-USER -i br-diam -j ACCEPT
sudo iptables -I DOCKER-USER -i br-enb -j ACCEPT

## Save the iptables rules
sudo iptables-save | sudo tee /etc/iptables/rules.v4

