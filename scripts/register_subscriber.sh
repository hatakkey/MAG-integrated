#!/bin/bash

:'open5gs-dbctl: Open5GS Database Configuration Tool (0.10.3)
FLAGS: --db_uri=mongodb://localhost
   add {imsi key opc}: adds a user to the database with default values
   add {imsi ip key opc}: adds a user to the database with default values and a IPv4 address for the UE
   addT1 {imsi key opc}: adds a user to the database with 3 differents apns

COMMANDS:
   addT1 {imsi ip key opc}: adds a user to the database with 3 differents apns and the same IPv4 address for th   e each apn
   remove {imsi}: removes a user from the database
   reset: WIPES OUT the database and restores it to an empty default
   static_ip {imsi ip4}: adds a static IP assignment to an already-existing user
   static_ip6 {imsi ip6}: adds a static IPv6 assignment to an already-existing user
   type {imsi type}: changes the PDN-Type of the first PDN: 0 = IPv4, 1 = IPv6, 2 = IPv4v6, 3 = v4 OR v6
   help: displays this message and exits
   default values are as follows: APN "internet", dl_bw/ul_bw 1 Gbps, PGW address is 127.0.0.3, IPv4 only
  
   add_ue_with_apn {imsi key opc apn}: adds a user to the database with a specific apn,
   add_ue_with_slice {imsi key opc apn sst sd}: adds a user to the database with a specific apn, sst and sd
   update_apn {imsi apn slice_num}: adds an APN to the slice number slice_num of an existent UE
   update_slice {imsi apn sst sd}: adds an slice to an existent UE
   showall: shows the list of subscriber in the db
   showpretty: shows the list of subscriber in the db in a pretty json tree format
   showfiltered: shows {imsi key opc apn ip} information of subscriber
   ambr_speed {imsi dl_value dl_unit ul_value ul_unit}: Change AMBR speed from a specific user and the  unit va   lues are "[0=bps 1=Kbps 2=Mbps 3=Gbps 4=Tbps ]
'

#### bng 4g subscriber (traditional BNG) 
docker exec  -u root integrated-dbctl open5gs-dbctl --db_uri=mongodb://mongo/open5gs add_ue_with_apn 206010000000001  465B5CE8B199B49FAA5F0A2EE238A6BE E8ED289DEBA952E4283B54E88E6183CC internet.mnc001.mcc206.gprs

