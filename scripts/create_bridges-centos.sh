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
#allow communiction for the clab

firewall-cmd --permanent --zone=docker --add-interface=br-s1ap
firewall-cmd --permanent --zone=docker --add-interface=br-gtpc
firewall-cmd --permanent --zone=docker --add-interface=br-gtpu
firewall-cmd --permanent --zone=docker --add-interface=br-diam
firewall-cmd --permanent --zone=docker --add-interface=br-enb

#reload the firewalld

firewall-cmd --reload



#then you need to enable that command to allow everything
#iptables -I FORWARD -i eno1 -o virbr0 -j ACCEPT
#iptables -D FORWARD -i eno1 -o virbr0 -j ACCEPT ; iptables -I FORWARD -i eno1 -o virbr0 -j ACCEPT

