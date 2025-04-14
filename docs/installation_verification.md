## 1. Pre-requirements for CLAB Setup
------
### 1.1. SELinux Configuration

Before starting the setup, **SELinux** should be disabled on your server for this CLAB to function properly. Check the current status of SELinux:

```bash
[root@compute-1 ~]# sestatus
SELinux status:      disabled
```
If status is different then  disabled, change it to disabled in /etc/selinux/config and reboot your server
```bash
[root@compute-1 ~]# more /etc/selinux/config
SELINUX=disabled
SELINUXTYPE=targeted
```

### 1.2. Firewalld configuration 
The firewall should be enabled ,If the firewall is not enabled or inactive, start the firewalld service:
```bash
[root@compute-1 MAG-integrated]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2025-03-09 11:09:29 EDT; 2 days ago
     Docs: man:firewalld(1)
 Main PID: 2015 (firewalld)
    Tasks: 2 (limit: 1646254)
   Memory: 45.7M
   CGroup: /system.slice/firewalld.service
           └─2015 /usr/libexec/platform-python -s /usr/sbin/firewalld --nofork --nopid
```   


## 1.3. **Create the needed bridges**:
Create the bridges
```bash   
[root@compute-1 scripts]# ./create_bridges-centos.sh
Warning: ALREADY_ENABLED: br-s1ap
success
Warning: ALREADY_ENABLED: br-gtpc
success
Warning: ALREADY_ENABLED: br-gtpu
success
Warning: ALREADY_ENABLED: br-diam
success
Warning: ALREADY_ENABLED: br-enb
success
success
```
---------------------------------------------------  
## 2. **SCTP is supported on host machine**

- Check if SCTP is supported on your host machine as the communication between HSS and MME is via SCTP and needs to be enabled on your host machine. 
- If you don’t have SCTP enabled, then a 4G session will fail with error  and you need to install SCTP.
In MME.log
```bash
ERROR: pid:Main in fd_sctp_create_bind_server@sctp.c:829: ERROR: in '(*sock = socket(family, SOCK_STREAM, IPPROTO_))' : Protocol not supported
```
- If command checksctp ---> “STCP supported” then skip (2) install SCTP (ubuntu ---> supported by default)
```bash
[root@compute-1 MAG-integrated]# checksctp
SCTP supported
```
- install sctp as below if not enabled
```bash
[root@compute-1]# dnf install kernel-modules-extra
[root@compute-1]# rm /etc/modprobe.d/sctp-blacklist.conf
[root@compute-1]# rm /etc/modprobe.d/sctp_diag-blacklist.conf
[root@compute-1]# dnf install lksctp-tools-1.0.18-3.el8.x86_64
```

## 3. **Deploy the ContainerLab Environment**:

Deploy the containerized network environment using the ContainerLab configuration:
```bash
[root@compute-1 MAG-integrated]# export CLAB_SKIP_SROS_SSH_KEY_CONFIG=true
[root@compute-1 MAG-integrated]# clab dep -t mag-integrated.clab.yml
12:31:16 INFO Containerlab started version=0.67.0
12:31:16 INFO Parsing & checking topology file=mag-integrated.clab.yml
12:31:16 INFO Creating docker network name=integ IPv4 subnet=192.168.41.0/24 IPv6 subnet="" MTU=0
12:31:16 INFO Creating lab directory path=/root/mag-integrated/clab-integrated
12:31:16 INFO Creating container name=mme
12:31:16 INFO Creating container name=hss
12:31:16 INFO Using existing config file (/root/mag-integrated/clab-integrated/MAG2/tftpboot/config.txt) instead of applying a new one
12:31:16 INFO Creating container name=pcrf
12:31:16 INFO Using existing config file (/root/mag-integrated/clab-integrated/MAG1/tftpboot/config.txt) instead of applying a new one
12:31:16 INFO Creating container name=radius
12:31:16 INFO Using existing config file (/root/mag-integrated/clab-integrated/TRA-integrated/tftpboot/config.txt) instead of applying a new one
12:31:16 INFO Creating container name=ue1
12:31:16 INFO Creating container name=mongo
12:31:16 INFO Creating container name=dbctl
12:31:16 INFO Creating container name=enodeb1
12:31:16 INFO Creating container name=bngblaster
12:31:16 INFO Creating container name=MAG1
12:31:16 INFO Creating container name=MAG2
12:31:16 INFO Creating container name=TRA-integrated
12:31:17 INFO Creating container name=webui
12:31:17 INFO Created link: MAG1:eth1 ▪┄┄▪ TRA-integrated:eth4
12:31:18 INFO Created link: MAG2:eth1 ▪┄┄▪ TRA-integrated:eth5
12:31:18 INFO Created link: TRA-integrated:eth6 ▪┄┄▪ bngblaster:eth1
12:31:18 INFO Created link: TRA-integrated:eth7 ▪┄┄▪ MAG1:eth2
12:31:18 INFO Created link: TRA-integrated:eth8 ▪┄┄▪ MAG2:eth2
12:31:18 INFO Created link: TRA-integrated:eth9 ▪┄┄▪ bngblaster:eth2
12:31:18 INFO Created link: TRA-integrated:eth10 ▪┄┄▪ radius:eth1
12:31:18 INFO Created link: br-gtpc:eth6 ▪┄┄▪ mme:eth2
12:31:18 INFO Created link: br-enb:eth32 ▪┄┄▪ enodeb1:eth3
12:31:18 INFO Created link: br-diam:eth13 ▪┄┄▪ mme:eth3
12:31:18 INFO Created link: br-gtpu:eth8 ▪┄┄▪ TRA-integrated:eth2
12:31:18 INFO Created link: br-s1ap:eth1 ▪┄┄▪ mme:eth1
12:31:18 INFO Created link: br-enb:eth34 ▪┄┄▪ ue1:eth1
12:31:18 INFO Created link: br-s1ap:eth2 ▪┄┄▪ enodeb1:eth1
12:31:18 INFO Created link: br-gtpc:eth7 ▪┄┄▪ TRA-integrated:eth1
12:31:18 INFO Created link: br-diam:eth14 ▪┄┄▪ TRA-integrated:eth3
12:31:18 INFO Created link: br-gtpu:eth10 ▪┄┄▪ enodeb1:eth2
12:31:18 INFO Created link: br-diam:eth15 ▪┄┄▪ hss:eth1
12:31:18 INFO Created link: br-diam:eth16 ▪┄┄▪ pcrf:eth1
12:31:18 INFO Executed command node=enodeb1 command="ip addr add 10.10.1.11/24 dev eth1" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="ip addr add 10.60.1.11/24 dev eth2" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="ip addr add 10.70.1.11/24 dev eth3" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="ip route add 50.50.50.0/24 via 10.60.1.1" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="ip route add 192.0.2.0/24 via 10.60.1.1" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="bash -c envsubst < /etc/srsran/enb.conf > enb.conf" stdout=""
12:31:18 INFO Executed command node=enodeb1 command="bash -c envsubst < /etc/srsran/rr.conf > rr.conf" stdout=""
12:31:18 INFO Executed command node=mme command="ip addr add 10.10.1.2/24 dev eth1" stdout=""
12:31:18 INFO Executed command node=mme command="ip addr add 10.20.1.2/24 dev eth2" stdout=""
12:31:18 INFO Executed command node=mme command="ip addr add 10.30.1.2/24 dev eth3" stdout=""
12:31:18 INFO Executed command node=mme command="ip route add 50.50.50.1/32 via 10.20.1.1" stdout=""
12:31:18 INFO Executed command node=hss command="ip addr add 10.30.1.3/24 dev eth1" stdout=""
12:31:18 INFO Executed command node=ue1 command="ip addr add 10.70.1.3/24 dev eth1" stdout=""
12:31:18 INFO Executed command node=ue1 command="bash -c envsubst < /etc/srsran/ue.conf > ue.conf" stdout=""
12:31:18 INFO Executed command node=pcrf command="ip addr add 10.30.1.4/24 dev eth1" stdout=""
12:31:18 INFO Executed command node=pcrf command="ip route add 50.50.50.0/24 via 10.30.1.1" stdout=""
12:31:18 INFO Adding host entries path=/etc/hosts
12:31:18 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-integrated.conf
╭───────────────────────────┬───────────────────────────────────────────┬─────────┬────────────────╮
│            Name           │                 Kind/Image                │  State  │ IPv4/6 Address │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-MAG1           │ vr-sros                                   │ running │ 192.168.41.5   │
│                           │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-MAG2           │ vr-sros                                   │ running │ 192.168.41.6   │
│                           │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-TRA-integrated │ vr-sros                                   │ running │ 192.168.41.7   │
│                           │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-bngblaster     │ linux                                     │ running │ 192.168.41.8   │
│                           │ htakkey/bngblaster:0.9.17                 │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-dbctl          │ linux                                     │ running │ 192.168.41.52  │
│                           │ gradiant/open5gs-dbctl:0.10.3             │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-enodeb1        │ linux                                     │ running │ 192.168.41.12  │
│                           │ openverso/srsran-4g:23_11                 │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-hss            │ linux                                     │ running │ 192.168.41.10  │
│                           │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-mme            │ linux                                     │ running │ 192.168.41.9   │
│                           │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-mongo          │ linux                                     │ running │ 192.168.41.50  │
│                           │ mongo:5.0.28                              │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-pcrf           │ linux                                     │ running │ 192.168.41.11  │
│                           │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-radius         │ linux                                     │ running │ 192.168.41.2   │
│                           │ freeradius/freeradius-server:3.2.3-alpine │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-ue1            │ linux                                     │ running │ 192.168.41.13  │
│                           │ openverso/srsran-4g:23_11                 │         │ N/A            │
├───────────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ integrated-webui          │ linux                                     │ running │ 192.168.41.51  │
│                           │ gradiant/open5gs-webui:2.7.1              │         │ N/A            │
╰───────────────────────────┴───────────────────────────────────────────┴─────────┴────────────────╯
```
### 3.1 **Access the container nodes**
The nodes are accessable via the IP address or the node name    
```bash  
docker exec -it integrated-hss        bash
docker exec -it integrated-mme        bash
docker exec -it integrated-ue1        bash   
docker exec -it integrated-enodeb1        bash   
docker exec -it integrated-radius     sh
ssh admin@integrated-TRA-integrated   ## password=admin     
ssh admin@integrated-MAG1 ## password=admin
ssh admin@integrated-MAG2 ## password=admin 
```

###4. **Downloadin the CLIscripts**
 
The following predefined scripts can be used to download the CLI scripts directly to the nodes

```bash 
[root@compute-1 scripts]# ./upload-cliscripts.sh
integrated-MAG1 is up, starting SFTP upload...
Upload complete for integrated-MAG1.
integrated-MAG2 is up, starting SFTP upload...
Upload complete for integrated-MAG2.
integrated-TRA-integrated is up, starting SFTP upload...
Upload complete for integrated-TRA-integrated.
[root@compute-1 scripts]# ssh -l admin integrated-TRA-integrated
```
 



      