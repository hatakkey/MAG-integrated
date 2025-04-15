### 1. **Clearing the logs**

Before starting your 4G FWA sessions , you can run a script that clears all relevant logs from Open5GS and UERANSIM. This ensures you start with a clean log environment, making it easier to identify and troubleshoot any issues that arise during the session

```bash
[root@compute-1 scripts]# ./clear_logs.sh
```
## 2. **Checking the logs**    
You can check the logs for the open5GS and UERANSIM
```bash
[root@compute-4 logs]# ls
enb1.log  hss.log  mme.log  pcrf.log  radiusd.log  ue1.log
[root@compute-4 logs]#
```
The below are the logs for single IMSI connected

### 2.1. **Checking the HSS logs**
The HSS diameter is connected with the MME

```bash
[root@compute-1 logs]# more hss.log
Open5GS daemon v2.7.1
03/12 21:04:24.500: [app] INFO: Configuration: '/opt/open5gs/etc/open5gs/hss.yaml' (../lib/app/ogs-init.c:133)
03/12 21:04:24.500: [app] INFO: File Logging: '/opt/open5gs/var/log/open5gs/hss.log' (../lib/app/ogs-init.c:136)
03/12 21:04:24.503: [dbi] INFO: MongoDB URI: 'mongodb://mongo/open5gs' (../lib/dbi/ogs-mongoc.c:130)
03/12 21:04:24.613: [app] INFO: HSS initialize...done (../src/hss/app-init.c:31)
03/12 21:04:24.617: [diam] INFO: CONNECTED TO 'mme.localdomain' (SCTP,soc#15): (../lib/diameter/common/logger.c:108)
```
 

### 2.2. **Checking the MME logs**

The MME is showing that diameter is connected with HSS , that enb-s1 is established and that the session is created.

```bash
[root@compute-1 logs]# more mme.log
Open5GS daemon v2.7.1

03/12 21:04:24.413: [app] INFO: Configuration: '/opt/open5gs/etc/open5gs/mme.yaml' (../lib/app/ogs-init.c:133)
03/12 21:04:24.413: [app] INFO: File Logging: '/opt/open5gs/var/log/open5gs/mme.log' (../lib/app/ogs-init.c:136)
03/12 21:04:24.419: [metrics] INFO: metrics_server() [http://10.30.1.2]:9090 (../lib/metrics/prometheus/context.c:299)
03/12 21:04:24.518: [gtp] INFO: gtp_server() [10.20.1.2]:2123 (../lib/gtp/path.c:30)
03/12 21:04:24.519: [gtp] INFO: gtp_connect() [1.1.1.1]:2123 (../lib/gtp/path.c:60)
03/12 21:04:24.519: [gtp] INFO: gtp_connect() [50.50.50.1]:2123 (../lib/gtp/path.c:60)
03/12 21:04:24.519: [mme] INFO: s1ap_server() [10.10.1.2]:36412 (../src/mme/s1ap-sctp.c:62)
03/12 21:04:24.519: [sctp] INFO: MME initialize...done (../src/mme/app-init.c:33)
03/12 21:04:24.617: [diam] INFO: CONNECTED TO 'hss.localdomain' (SCTP,soc#8): (../lib/diameter/common/logger.c:108)
03/12 21:04:34.662: [mme] INFO: eNB-S1 accepted[10.10.1.11]:34416 in s1_path module (../src/mme/s1ap-sctp.c:114)
03/12 21:04:34.662: [mme] INFO: eNB-S1 accepted[10.10.1.11] in master_sm module (../src/mme/mme-sm.c:108)
03/12 21:04:34.662: [mme] INFO: [Added] Number of eNBs is now 1 (../src/mme/mme-context.c:2829)
03/12 21:04:34.662: [mme] INFO: eNB-S1[10.10.1.11] max_num_of_ostreams : 30 (../src/mme/mme-sm.c:150)
03/12 21:04:36.471: [mme] INFO: InitialUEMessage (../src/mme/s1ap-handler.c:406)
03/12 21:04:36.471: [mme] INFO: [Added] Number of eNB-UEs is now 1 (../src/mme/mme-context.c:4739)
03/12 21:04:36.471: [mme] INFO: Unknown UE by S_TMSI[G:2,C:1,M_TMSI:0xc0000044] (../src/mme/s1ap-handler.c:485)
03/12 21:04:36.471: [mme] INFO:     ENB_UE_S1AP_ID[1] MME_UE_S1AP_ID[1] TAC[1] CellID[0x101] (../src/mme/s1ap-handler.c:585)
03/12 21:04:36.471: [mme] INFO: Unknown UE by GUTI[G:2,C:1,M_TMSI:0xc0000044] (../src/mme/mme-context.c:3586)
03/12 21:04:36.471: [mme] INFO: [Added] Number of MME-UEs is now 1 (../src/mme/mme-context.c:3379)
03/12 21:04:36.471: [emm] INFO: [] Attach request (../src/mme/emm-sm.c:433)
03/12 21:04:36.471: [emm] INFO:     GUTI[G:2,C:1,M_TMSI:0xc0000044] IMSI[Unknown IMSI] (../src/mme/emm-handler.c:236)
03/12 21:04:36.494: [emm] INFO: Identity response (../src/mme/emm-sm.c:403)
03/12 21:04:36.494: [emm] INFO:     IMSI[206010000000001] (../src/mme/emm-handler.c:428)
03/12 21:04:36.571: [mme] INFO: [Added] Number of MME-Sessions is now 1 (../src/mme/mme-context.c:4753)
03/12 21:04:39.160: [gtp] WARNING: [0] REMOTE Request Duplicated. Retransmit! for step 2 type 1 peer [50.50.50.1]:2123 (../lib/gtp/xact.c:548)
03/12 21:04:39.468: [emm] INFO: [206010000000001] Attach complete (../src/mme/emm-sm.c:1394)
03/12 21:04:39.468: [emm] INFO:     IMSI[206010000000001] (../src/mme/emm-handler.c:275)
03/12 21:04:39.468: [emm] INFO:     UTC [2025-03-12T21:04:39] Timezone[0]/DST[0] (../src/mme/emm-handler.c:281)
03/12 21:04:39.468: [emm] INFO:     LOCAL [2025-03-12T21:04:39] Timezone[0]/DST[0] (../src/mme/emm-handler.c:285)
```    

### 2.3. **Checking the eNB logs**
The eNB log is showing that the user is connected
```bash
[root@compute-1 logs]#  more enb1.log
Active RF plugins: libsrsran_rf_uhd.so libsrsran_rf_zmq.so
Inactive RF plugins:
---  Software Radio Systems LTE eNodeB  ---

Reading configuration file enb.conf...
Couldn't open sib.conf, trying /root/.config/srsran/sib.conf
Couldn't open /root/.config/srsran/sib.conf either, trying /etc/srsran/sib.conf
Couldn't open rb.conf, trying /root/.config/srsran/rb.conf
Couldn't open /root/.config/srsran/rb.conf either, trying /etc/srsran/rb.conf

Built in Release mode using commit eea87b1d8 on branch HEAD.

Opening 1 channels in RF device=zmq with args=tx_port=tcp://*:2000,rx_port=tcp://10.70.1.3:2001,
id=enb,base_srate=23.04e6
Supported RF device list: UHD zmq file
CHx base_srate=23.04e6
CHx id=enb
Current sample rate is 1.92 MHz with a base rate of 23.04 MHz (x12 decimation)
CH0 rx_port=tcp://10.70.1.3:2001
CH0 tx_port=tcp://*:2000

==== eNodeB started ===
Type <t> to view trace
Current sample rate is 11.52 MHz with a base rate of 23.04 MHz (x2 decimation)
Current sample rate is 11.52 MHz with a base rate of 23.04 MHz (x2 decimation)
Setting frequency: DL=2680.0 Mhz, UL=2560.0 MHz for cc_idx=0 nof_prb=50
Closing stdin thread.
RACH:  tti=341, cc=0, pci=1, preamble=34, offset=0, temp_crnti=0x46
User 0x46 connected
```
### 2.4. **Checking the 4G FWA home-user logs**

UE1 log showing that the session is created with IP 180.0.0.2
```bash
[root@compute-1 logs]#   more ue1.log
Active RF plugins: libsrsran_rf_uhd.so libsrsran_rf_zmq.so
Inactive RF plugins:
Reading configuration file ue.conf...

Built in Release mode using commit eea87b1d8 on branch HEAD.

Opening 1 channels in RF device=zmq with args=tx_port=tcp://10.70.1.3:2001,rx_port=tcp://10.70.1
.11:2000,id=ue,base_srate=23.04e6
Supported RF device list: UHD zmq file
CHx base_srate=23.04e6
CHx id=ue
Current sample rate is 1.92 MHz with a base rate of 23.04 MHz (x12 decimation)
CH0 rx_port=tcp://10.70.1.11:2000
CH0 tx_port=tcp://10.70.1.3:2001
Waiting PHY to initialize ... done!
Attaching UE...
Closing stdin thread.
Current sample rate is 11.52 MHz with a base rate of 23.04 MHz (x2 decimation)
Current sample rate is 11.52 MHz with a base rate of 23.04 MHz (x2 decimation)
.
Found Cell:  Mode=FDD, PCI=1, PRB=50, Ports=1, CP=Normal, CFO=0.0 KHz
Found PLMN:  Id=20601, TAC=1
Random Access Transmission: seq=34, tti=341, ra-rnti=0x2
RRC Connected
Random Access Complete.     c-rnti=0x46, ta=0
Network attach successful. IP: 180.0.0.2
 nTp) ((t) 12/3/2025 21:4:39 TZ:0
```
    

