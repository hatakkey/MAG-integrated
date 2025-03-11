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

### 1.2. firewalld configuration 
The firewall should be enabled ,If the firewall is not enabled or inactive, start the firewalld service:
```bash
[root@compute-1 MAG-cups]# systemctl status firewalld
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


## 1.3. **create the needed bridges**:
   create the brideges
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
## 2. **Deploy the ContainerLab Environment**:

   Deploy the containerized network environment using the ContainerLab configuration:
   ```bash
   [root@compute-1 MAG-integrated]# clab dep -t mag-integrated.clab.yml
   23:20:33 INFO Containerlab started version=0.66.0
   23:20:33 INFO Parsing & checking topology file=mag-integrated.clab.yml
   23:20:33 INFO Creating docker network name=integ IPv4 subnet=192.168.41.0/24 IPv6 subnet="" MTU=0
   23:20:34 INFO Creating lab directory path=/root/MAG-integrated/clab-integrated
   23:20:34 INFO Creating container name=radius
   23:20:34 INFO Using existing config file (/root/MAG-integrated/clab-integrated/BNG-2/tftpboot/config.txt) instead of applying a new one
   23:20:34 INFO Creating container name=enodeb1
   23:20:34 INFO Creating container name=dbctl
   23:20:34 INFO Creating container name=hss
   23:20:34 INFO Using existing config file (/root/MAG-integrated/clab-integrated/TRA/tftpboot/config.txt) instead of applying a new one
   23:20:34 INFO Creating container name=ue1
   23:20:34 INFO Creating container name=bngblaster
   23:20:34 INFO Creating container name=mme
   23:20:34 INFO Creating container name=mongo
   23:20:34 INFO Using existing config file (/root/MAG-integrated/clab-integrated/BNG-1/tftpboot/config.txt) instead of applying a new one
   23:20:34 INFO Creating container name=pcrf
   23:20:34 INFO Creating container name=BNG-2
   23:20:34 INFO Creating container name=TRA
   23:20:34 INFO Creating container name=BNG-1
   23:20:57 INFO Created link: TRA:eth3 ▪┄┄▪ BNG-1:eth1
   23:20:57 INFO Created link: TRA:eth4 ▪┄┄▪ BNG-2:eth1
   23:20:58 INFO Created link: BNG-1:eth3 ▪┄┄▪ TRA:eth10
   23:20:58 INFO Created link: BNG-2:eth3 ▪┄┄▪ TRA:eth11
   23:20:58 INFO Created link: TRA:eth14 ▪┄┄▪ bngblaster:eth1
   23:20:58 INFO Created link: TRA:eth15 ▪┄┄▪ BNG-1:eth2
   23:20:58 INFO Created link: TRA:eth16 ▪┄┄▪ BNG-2:eth2
   23:20:58 INFO Created link: TRA:eth17 ▪┄┄▪ bngblaster:eth2
   23:20:58 INFO Created link: radius:eth1 ▪┄┄▪ TRA:eth20
   23:20:59 INFO Creating container name=webui
   23:21:25 INFO Created link: br-gtpc:eth6 ▪┄┄▪ mme:eth2
   23:21:25 INFO Created link: br-gtpu:eth8 ▪┄┄▪ TRA:eth5
   23:21:26 INFO Created link: br-gtpc:eth7 ▪┄┄▪ TRA:eth2
   23:21:26 INFO Created link: br-enb:eth32 ▪┄┄▪ enodeb1:eth3
   23:21:26 INFO Created link: br-s1ap:eth1 ▪┄┄▪ mme:eth1
   23:21:26 INFO Created link: br-s1ap:eth2 ▪┄┄▪ enodeb1:eth1
   23:21:26 INFO Created link: br-gtpu:eth10 ▪┄┄▪ enodeb1:eth2
   23:21:26 INFO Created link: br-diam:eth13 ▪┄┄▪ mme:eth3
   23:21:26 INFO Created link: br-s1ap:eth5 ▪┄┄▪ TRA:eth1
   23:21:26 INFO Created link: br-enb:eth34 ▪┄┄▪ ue1:eth1
   23:21:26 INFO Created link: br-diam:eth14 ▪┄┄▪ TRA:eth7
   23:21:26 INFO Created link: br-diam:eth15 ▪┄┄▪ hss:eth1
   23:21:26 INFO Created link: br-diam:eth16 ▪┄┄▪ pcrf:eth1
   23:21:26 INFO Executed command node=mme command="ip addr add 10.10.1.2/24 dev eth1" stdout=""
   23:21:26 INFO Executed command node=mme command="ip addr add 10.20.1.2/24 dev eth2" stdout=""
   23:21:26 INFO Executed command node=mme command="ip addr add 10.30.1.2/24 dev eth3" stdout=""
   23:21:26 INFO Executed command node=mme command="ip route add 50.50.50.1/32 via 10.20.1.1" stdout=""
   23:21:26 INFO Executed command node=pcrf command="ip addr add 10.30.1.4/24 dev eth1" stdout=""
   23:21:26 INFO Executed command node=pcrf command="ip route add 50.50.50.0/24 via 10.30.1.1" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="ip addr add 10.10.1.11/24 dev eth1" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="ip addr add 10.60.1.11/24 dev eth2" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="ip addr add 10.70.1.11/24 dev eth3" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="ip route add 50.50.50.0/24 via 10.60.1.1" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="ip route add 1.1.1.0/24 via 10.60.1.1" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="bash -c envsubst < /etc/srsran/enb.conf > enb.conf" stdout=""
   23:21:26 INFO Executed command node=enodeb1 command="bash -c envsubst < /etc/srsran/rr.conf > rr.conf" stdout=""
   23:21:26 INFO Executed command node=ue1 command="ip addr add 10.70.1.3/24 dev eth1" stdout=""
   23:21:26 INFO Executed command node=ue1 command="bash -c envsubst < /etc/srsran/ue.conf > ue.conf" stdout=""
   23:21:26 INFO Executed command node=hss command="ip addr add 10.30.1.3/24 dev eth1" stdout=""
   23:21:26 INFO Adding host entries path=/etc/hosts
   23:21:26 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-integrated.conf
   ╭───────────────────────┬───────────────────────────────────────────┬─────────┬────────────────╮
   │          Name         │                 Kind/Image                │  State  │ IPv4/6 Address │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-BNG-1      │ vr-sros                                   │ running │ 192.168.41.5   │
   │                       │ registry.srlinux.dev/pub/vr-sros:24.10.R3 │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-BNG-2      │ vr-sros                                   │ running │ 192.168.41.6   │
   │                       │ registry.srlinux.dev/pub/vr-sros:24.10.R3 │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-TRA        │ vr-sros                                   │ running │ 192.168.41.7   │
   │                       │ registry.srlinux.dev/pub/vr-sros:24.10.R3 │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-bngblaster │ linux                                     │ running │ 192.168.41.8   │
   │                       │ ghcr.io/asadarafat/bngblaster:main        │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-dbctl      │ linux                                     │ running │ 192.168.41.52  │
   │                       │ gradiant/open5gs-dbctl:0.10.3             │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-enodeb1    │ linux                                     │ running │ 192.168.41.12  │
   │                       │ openverso/srsran-4g:23_11                 │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-hss        │ linux                                     │ running │ 192.168.41.10  │
   │                       │ gradiant/open5gs:2.7.1                    │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-mme        │ linux                                     │ running │ 192.168.41.9   │
   │                       │ gradiant/open5gs:2.7.1                    │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-mongo      │ linux                                     │ running │ 192.168.41.50  │
   │                       │ mongo:5.0.28                              │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-pcrf       │ linux                                     │ running │ 192.168.41.11  │
   │                       │ gradiant/open5gs:2.7.1                    │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-radius     │ linux                                     │ running │ 192.168.41.2   │
   │                       │ freeradius/freeradius-server:3.2.3-alpine │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-ue1        │ linux                                     │ running │ 192.168.41.13  │
   │                       │ openverso/srsran-4g:23_11                 │         │ N/A            │
   ├───────────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
   │ integrated-webui      │ linux                                     │ running │ 192.168.41.51  │
   │                       │ gradiant/open5gs-webui:2.7.1              │         │ N/A            │
   ╰───────────────────────┴───────────────────────────────────────────┴─────────┴────────────────╯
	
	### 2.1 **access the container nodes**
    The nodes are accessable via the IP address or the node name
				
				```bash  
				docker exec -it cups-hss        bash
				docker exec -it cups-mme        bash
				docker exec -it cups-bsf        bash			
				docker exec -it cups-enb        bash			
				docker exec -it cups-radius     sh
				ssh admin@cups-TRA    ## password=admin    
    ssh admin@cups-up-1   ## password=admin     
    ssh admin@cups-up-1   ## password=admin     
    ssh admin@cups-mag-c1 ## password=admin
    ssh admin@cups-mag-c2 ## password=admin		
				```
      