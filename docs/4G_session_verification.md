## 1. **start the 4G session**
----
### 1.1. start 4G session
use the below script to start the 4G session
```bash
[root@compute-1 scripts]# ./start_4g_bng.sh
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
IP route added successfully.
```
### 1.1.1 check the session on BNG 

The session is created on BNG-1
```bash
*A:BNG-1# show service active-subscribers hierarchy
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- 206010000000001
   (sub-func1)
   |
   +-- sap:[pxc-7.b:1.8] - sla:sla-func1
       |
       +-- IPOE-session - mac:00:03:00:06:00:05 - svc:51
           |
           +-- 180.0.0.2 - GTP

-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
=========================================================================
```

More info about the session can ve obtained using the below command
```bash
*A:BNG-1#show subscriber-mgmt gtp s11 session
===============================================================================
GTP S11 sessions
===============================================================================
IMSI                        : 206010000000001
APN                         : internet.mnc001.mcc206.gprs
-------------------------------------------------------------------------------
Peer router                 : 2043
Peer address                : 10.20.1.2
Remote control TEID         : 992
Local control TEID          : 3
PDN TEID                    : 393216
Charging characteristics    : (None)
Uplink AMBR (kbps)          : 1000000
Downlink AMBR (kbps)        : 1000000
User Location Info - TAI    : MCC:206 MNC:01 TAC:0001
User Location Info - ECGI   : MCC:206 MNC:01 ECI:0000101
Ipoe-session SAP            : [pxc-7.b:1.8]
Ipoe-session Mac Address    : 00:03:00:06:00:05

-------------------------------------------------------------------------------
No. of GTP S11 sessions: 1
===============================================================================
```

The connection with the MME can be checked via the below command
```bash
*A:BNG-1# show router 2043 gtp peer
===============================================================================
Peers
===============================================================================
Remote address              : 10.20.1.2
UDP port                    : 2123
-------------------------------------------------------------------------------
State                       : up
Local address               : 50.50.50.1
Profile                     : UERANSIM
Control protocol            : gtpv2-c
Interface type              : s11
Restart count               : 1
Time                        : 2025/03/12 22:04:38
-------------------------------------------------------------------------------
No. of Peers: 1
```




### 1.6. checking the UE 
 You can check the UE VM that tun_srsue is created with the UE IP 180.0.0.2/24
```bash
[root@compute-1 scripts]# docker exec -it integrated-ue1 bash
root@ue1:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
3: tun_srsue: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 180.0.0.2/24 scope global tun_srsue
       valid_lft forever preferred_lft forever
1838: eth0@if1839: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:29:0d brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.41.13/24 brd 192.168.41.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:290d/64 scope link
       valid_lft forever preferred_lft forever
1865: eth1@if1864: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:85:88:ca brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.70.1.3/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe85:88ca/64 scope link
       valid_lft forever preferred_lft forever
root@ue1:/# ip r
default via 192.168.41.1 dev eth0
1.1.1.0/24 dev tun_srsue scope link
10.70.1.0/24 dev eth1 proto kernel scope link src 10.70.1.3
180.0.0.0/24 dev tun_srsue proto kernel scope link src 180.0.0.2
192.168.41.0/24 dev eth0 proto kernel scope link src 192.168.41.13  
```
## 1.7 **checking the dataplane**

the UE can reach the internet VRF 500 on TRA via the tun_srsue
```bash
root@ue1:/# ip r
default via 192.168.41.1 dev eth0
1.1.1.0/24 dev tun_srsue scope link
10.70.1.0/24 dev eth1 proto kernel scope link src 10.70.1.3
180.0.0.0/24 dev tun_srsue proto kernel scope link src 180.0.0.2
192.168.41.0/24 dev eth0 proto kernel scope link src 192.168.41.13
```
```bash
root@ue1:/# ping 1.1.1.201
PING 1.1.1.201 (1.1.1.201) 56(84) bytes of data.
64 bytes from 1.1.1.201: icmp_seq=1 ttl=63 time=320 ms
64 bytes from 1.1.1.201: icmp_seq=2 ttl=63 time=431 ms
64 bytes from 1.1.1.201: icmp_seq=3 ttl=63 time=299 ms
```






#### 1.8 **stopping the session** 
You can stop the 4G session using this script

```bash
[root@compute-1 scripts]# ./stop_4g_bng.sh
[root@compute-1 scripts]# ./stop_4g_bng.sh
Stopping eNodeB and UE processes...
Processes after pkill:
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 21:38 pts/0    00:00:00 /bin/bash
root         170       0  0 21:45 pts/1    00:00:00 bash
root         321       0  0 22:08 ?        00:00:00 bash -c pkill -9 srsenb; sleep 2; echo 'Processes after pkill:'; ps -ef
root         329     321  0 22:08 ?        00:00:00 ps -ef
Processes after pkill:
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 21:38 pts/0    00:00:00 /bin/bash
root         688       0  0 21:52 pts/2    00:00:00 bash
root        1371       0  0 22:08 ?        00:00:00 bash -c pkill -9 srsue; sleep 2; echo 'Processes after pkill:'; ps -ef
root        1379    1371  0 22:08 ?        00:00:00 ps -ef
Process check completed.
```



