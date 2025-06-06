## 1. **FWA 4G session Verification**
----
### 1.1 **Start the FWA debug**

Enable call-trace on MAG2 (session is by default terminated on MAG2) using the below predefined script.

```bash
A:admin@MAG2# show ct-fwa
INFO: CLI #2060: Entering exclusive configuration mode
INFO: CLI #2061: Uncommitted changes are discarded on configuration mode exit
# TiMOS-B-25.3.R1 both/x86_64 Nokia 7750 SR Copyright (c) 2000-2025 Nokia.
# All rights reserved. All use subject to applicable license agreements.
# Built on Wed Mar 12 21:50:19 UTC 2025 by builder in /builds/253B/R1/panos/main/sros
# Configuration format version 25.3 revision 0

# Generated 2025-04-15T13:18:52.0+02:00 by admin from 172.31.255.29
# Last modified 2025-04-15T13:18:52.0+02:00 by admin (MD-CLI) from 172.31.255.29

debug {
    router "vprn-2043" {
        radius {
            servers {
                detail-level medium
                packet-types {
                    authentication true
                    accounting true
                    coa true
                }
                attribute "radius-attr" {
                    type 1
                    value {
                        string "206010000000001"
                    }
                }
            }
        }
    }
    subscriber-mgmt {
        gtp {
            packets {
                mode all
                detail-level high
            }
        }
    }
}

# Finished 2025-04-15T13:18:52.0+02:00
INFO: CLI #2064: Exiting exclusive configuration mode
INFO: CLI #2054: Entering global configuration mode
INFO: CLI #2056: Exiting global configuration mode
Executed 35 lines in 0.0 seconds from file "cf1:\scripts-md\ct-fwa"
```

Note: The call-trace script includes all necessary protocol debugging and log settings via log-77. However, output redirection is not handled within the script and must be performed manually.
      To view the debug output in your session you should subscribe to log-id 77, using command:
```bash
tools perform log subscribe-to log-id 77
```
 
To stop the output redirection  to your session, unsubscribe from log-id 77, using command:
```bash
tools perform log unsubscribe-from log-id 77
```
### 1.2 **Start 4G session**
Use the below predefined script to start the 4G session and wait until the scripts returns "IP route added successfully".

It takes 15~20 secs to have the session UP.

```bash
[root@compute-1 scripts]# ./start_4g_bng.sh
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
Waiting for tun_srsue to be ready...
IP route added successfully.
```

### 1.3 **Check the session on MAG2**

The session is created on MAG2 and can be checked via the predefined script.
```bash
A:admin@MAG2# show s-fwa
===============================================================================
Peers
===============================================================================
Host identity                          Status        Default Preference Active
-------------------------------------------------------------------------------
pcrf.localdomain                       I-Open        No      50         Yes
-------------------------------------------------------------------------------
No. of peers: 1
===============================================================================

===============================================================================
Peer "pcrf.localdomain"
===============================================================================
Index                       : 1
Status                      : I-Open
Administrative state        : enabled
Active                      : Yes
Active applications         : (relay)
Last disconnect cause       : rebooting
Preference                  : 50
Default peer                : No
Connection timer (s)        : N/A
Watchdog timer (s)          : 21
Pending messages            : 0
Remote realm                : localdomain
Remote IP address           : 10.30.1.4
Remote TCP port             : 3868
Remote Origin-State-Id      : 1744116020
Local host identity         : bng.localdomain
Local realm                 : localdomain
Local IP address            : 50.50.50.1
Local TCP port              : 51850
Last management change      : 04/07/2025 20:57:18
===============================================================================

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- 206010000000001
   (sub-fwa)
   |
   +-- sap:[pxc-7.b:1.8] - sla:sla-fwa
       |
       +-- IPOE-session - mac:00:03:00:14:00:05 - svc:51
           |
           +-- 180.0.0.1 - GTP

-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
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
Time                        : 2025/04/13 15:49:22

-------------------------------------------------------------------------------
No. of Peers: 1
===============================================================================
GTP system summary
===============================================================================
Actual number of MME                                    : 1
Actual number of ENODE-B                                : 0
Actual number of S11 Sessions                           : 1
Actual number of S11 Idle Sessions                      : 1
Actual number of Mobile Gateways                        : 0
Actual number of Uplinks                                : 0
Actual number of Uplinks in Hold                        : 0
===============================================================================
GTP S11 sessions
===============================================================================
IMSI                        : 206010000000001
APN                         : internet.mnc001.mcc206.gprs
-------------------------------------------------------------------------------
Peer router                 : 2043
Peer address                : 10.20.1.2
Remote control TEID         : 484
Local control TEID          : 10
PDN TEID                    : 1310720
Charging characteristics    : (None)
Uplink AMBR (kbps)          : 60000
Downlink AMBR (kbps)        : 110000
User Location Info - TAI    : MCC:206 MNC:01 TAC:0001
User Location Info - ECGI   : MCC:206 MNC:01 ECI:0000101
Ipoe-session SAP            : [pxc-7.b:1.8]
Ipoe-session Mac Address    : 00:03:00:14:00:05
Bearer 5
  Rem S1-U address          : 0.0.0.0
  rem TEID                  : 0
  loc TEID                  : 1310725
  uplink GBR (kbps)         : 0
  uplink MBR (kbps)         : 0
  downlink GBR (kbps)       : 0
  downlink MBR (kbps)       : 0
  QoS Class ID              : 9
  alloc/ret priority        : 1

-------------------------------------------------------------------------------
No. of GTP S11 sessions: 1
===============================================================================
GTP statistics
===============================================================================
tx echo requests                                        : 301
rx echo responses                                       : 293
path faults                                             : 1
tx create session responses                             : 10
tx delete session responses                             : 8
tx modify bearer responses                              : 13
tx rls access bearers responses                         : 13
tx downlink notifications                               : 4
rx create session requests                              : 10
rx delete session requests                              : 8
rx modify bearer requests                               : 13
rx rls access bearers request                           : 13
rx unknown pkts                                         : 4
rx discarded pkts                                       : 7
rx pkts                                                 : 344
tx pkts                                                 : 352
===============================================================================
Subscriber Management Statistics for System
===============================================================================
       Type                                Current     Peak      Peak Timestamp
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   IPOE Mngd Hosts  - GTP                    1        1 04/13/2025 15:54:51
-------------------------------------------------------------------------------
Total  IPOE Hosts                                1        1 04/13/2025 15:54:51
       IPv4 Hosts                                1        1 04/13/2025 15:54:51
       System Hosts Scale                        1        1 04/13/2025 15:54:51
-------------------------------------------------------------------------------
===============================================================================
Peak values last reset at : 04/13/2025 15:54:51

===============================================================================
SLA Profile Statistics
===============================================================================
SLA-Profile Name                           Current     Peak      Peak Timestamp
-------------------------------------------------------------------------------
sla-default                                      0        0
sla-fwa                                          1        1 04/08/2025 11:06:13
sla-ipoe                                         0       10 04/08/2025 17:06:39
sla-pppoe                                        0       10 04/08/2025 11:06:25
-------------------------------------------------------------------------------
Total                                            1
===============================================================================
# TiMOS-B-25.3.R1 both/x86_64 Nokia 7750 SR Copyright (c) 2000-2025 Nokia.
# All rights reserved. All use subject to applicable license agreements.
# Built on Wed Mar 12 21:50:19 UTC 2025 by builder in /builds/253B/R1/panos/main/sros
# Configuration format version 25.3 revision 0
# Generated 2025-04-13T15:54:51.5+02:00 by admin from 172.31.255.29
# Last modified 2025-04-13T15:48:46.3+02:00 by admin (MD-CLI) from 172.31.255.29
```

### 1.4 **GTP session debug output**

Since the gtp and Radius debug was enabled prior to the FWA 4G session activation we will see the call-trace output on the CLI session as shown below.

```bash
223 2025/04/13 15:49:21.501 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 76
UDP Hdr: Src: 2123, Dst: 2123, Len: 56
GTPv2 Hdr: Len: 44, Seq: 24, TEID: 0x9
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Delete Session Req
  [EBI]                    : 0x5
  [USER LOCATION INFO]     : TAI + ECGI: 02 f6 10 00 01 02 f6 10 00 00 01 01 01 00
  [INDICATION]             : 0x08000000000000000000

224 2025/04/13 15:49:21.503 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Transmit
  Accounting-Request(4) 100.0.0.2:1813 id 65 len 659 vrid 3 pol FreeRadius-acct
    STATUS TYPE [40] 4 Stop(2)
    NAS IP ADDRESS [4] 4 192.0.2.11
    USER NAME [1] 15 206010000000001
    FRAMED IP ADDRESS [8] 4 180.0.0.1
    FRAMED IP NETMASK [9] 4 255.255.255.255
    CLASS [25] 5 0x7573657231
    CALLED STATION ID [30] 8 internet
    NAS IDENTIFIER [32] 4 MAG2
    SESSION ID [44] 22 ABDE1B0000001867FBBF88
    SESSION TIME [46] 4 345
    TERMINATE CAUSE [49] 4 User Request(1)
    VSA [26] 37 Nokia(6527)
      ERROR CODE [226] 4 275
      ERROR MESSAGE [227] 29 GTP user initiated disconnect
    MULTI SESSION ID [50] 22 ABDE1B0000001A67FBBF88
    EVENT TIMESTAMP [55] 4 1744552161
    NAS PORT TYPE [61] 4 Virtual(5)
    NAS PORT ID [87] 62 GTP rtr-3#lip-50.50.50.1#rip-10.20.1.2#lteid-1179648#rteid-484
    VSA [26] 35 Nokia(6527)
      SUBSC ID STR [11] 15 206010000000001
      SUBSC PROF STR [12] 7 sub-fwa
      SLA PROF STR [13] 7 sla-fwa
    VSA [241.26] 3 Nokia(6527)
      SPI SHARING_ID [47] 3 SAP
    VSA [26] 19 Nokia(6527)
      CHADDR [27] 17 00:03:00:12:00:05
    DELAY TIME [41] 4 0
    AUTHENTIC [45] 4 RADIUS(1)
    VSA [26] 35 3GPP(10415)
      IMEISV [20] 16 3534900698733153
      IMSI [1] 15 206010000000001
    VSA [26] 29 Nokia(6527)
      WLAN APN NAME [146] 27 internet.mnc001.mcc206.gprs
    VSA [26] 15 3GPP(10415)
      USER LOCATION INFO [22] 13 TAI-ECGI 0x02f610000102f61000000101
    VSA [241.26] 60 Nokia(6527)
      GTP BEARER FTEID [56] 60 rtr-3#bid-5#lip-50.50.50.1#rip-0.0.0.0#lteid-1179653#rteid-0
    INPUT PACKETS [47] 4 0
    INPUT OCTETS [42] 4 0
    OUTPUT PACKETS [48] 4 0
    OUTPUT OCTETS [43] 4 0
    VSA [26] 112 Nokia(6527)
      INPUT V6 PACKETS [194] 4 0
      INPUT V6 OCTETS [195] 4 0
      OUTPUT V6 PACKETS [197] 4 0
      OUTPUT V6 OCTETS [198] 4 0
      OUTPUT_INPROF_OCTETS_64 [21] 10 0x00010000000000000000
      OUTPUT_OUTPROF_OCTETS_64 [22] 10 0x00010000000000000000
      OUTPUT_INPROF_PACKETS_64 [25] 10 0x00010000000000000000
      OUTPUT_OUTPROF_PACKETS_64 [26] 10 0x00010000000000000000
      INPUT_STATMODE [107] 14 0x8001 minimal
      INPUT_ALL_OCTETS_64 [116] 10 0x80010000000000000000
      INPUT_ALL_PACKETS_64 [118] 10 0x80010000000000000000



226 2025/04/13 15:49:21.503 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 51
UDP Hdr: Src: 2123, Dst: 2123, Len: 31
GTPv2 Hdr: Len: 19, Seq: 24, TEID: 0x1e4
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Delete Session Resp
  [CAUSE]                  : SUCCESS
  [RECOVERY]               : 1

227 2025/04/13 15:49:21.504 CEST minor: WLAN_GW #2009 Base CPM-GTP
The state of the GTP Peer 10.20.1.2 port 2123 in router vprn2043 has changed to idle.

228 2025/04/13 15:49:21.504 CEST minor: WLAN_GW #2006 Base CPM-GTP
Connection interrupted with GTP Peer 10.20.1.2 port 2123 in router vprn2043.

229 2025/04/13 15:49:21.504 CEST warning: SVCMGR #2501 Base Subscriber deleted
Subscriber 206010000000001 has been removed from the system

230 2025/04/13 15:49:21.508 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Receive
  Accounting-Response(5) id 65 len 20 from 100.0.0.2:1813 vrid 3 pol FreeRadius-acct





231 2025/04/13 15:49:21.611 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 242
UDP Hdr: Src: 2123, Dst: 2123, Len: 222
GTPv2 Hdr: Len: 210, Seq: 25, TEID: 0x0
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Create Session Req
  [IMSI]                   : 206010000000001
  [MEI]                    : 3534900698733153
  [USER LOCATION INFO]     : TAI + ECGI: 02 f6 10 00 01 02 f6 10 00 00 01 01 00 00
  [SERVING NETWORK]        : 0x2f610
  [RAT TYPE]               : EUTRAN
  [INDICATION]             : 0x00100000000002000000
  [S11 MME-C F-TEID]       : 0x000001e4 IPv4: 10.20.1.2
  [S5/S8-C PGW F-TEID]     : 0x00000000 IPv4: 50.50.50.1
  [APN]                    : internet.mnc001.mcc206.gprs
  [SELECTION MODE]         : MS/NW APN Verified
  [PDN TYPE]               : IPv4
  [PDN ADDR ALLOC]         : IPv4 0.0.0.0
  [APN RESTRICTION]        : No Context/Restriction
  [AMBR]                   : UL: 1000000 kbps, DL: 1000000 kbps
  [BEARER CXT]             : Add :0x5
      Bearer Qos:  PVI: 0x00 PL: 0x08 PCI: 0x40 QCI: 0x09
      MBR: UL: 0 kbps, DL: 0 kbps GMBR: UL: 0 kbps, DL: 0 kbps
  [TIME_ZONE]              : 0 DST: NO

232 2025/04/13 15:49:21.611 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 41
UDP Hdr: Src: 2123, Dst: 2123, Len: 21
GTPv2 Hdr: Len: 9, Seq: 0,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Echo Req
  [RECOVERY]               : 1

233 2025/04/13 15:49:21.612 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Transmit
  Access-Request(1) 100.0.0.2:1812 id 10 len 274 vrid 3 pol FreeRadius-auth
    USER NAME [1] 15 206010000000001
    PASSWORD [2] 16 z4RKZceV3mNIgD9isUJ7b.
    NAS IP ADDRESS [4] 4 192.0.2.11
    VSA [26] 18 3GPP(10415)
      IMEISV [20] 16 3534900698733153
    VSA [26] 29 Nokia(6527)
      WLAN APN NAME [146] 27 internet.mnc001.mcc206.gprs
    VSA [26] 60 3GPP(10415)
      RAT TYPE [21] 1 EUTRAN(6)
      USER LOCATION INFO [22] 13 TAI-ECGI 0x02f610000102f61000000101
      NEGOTIATED QOS PROFILE [5] 23 08-6009000f4240000f4240
      IMSI [1] 15 206010000000001
    NAS PORT TYPE [61] 4 Virtual(5)
    NAS PORT ID [87] 56 GTP rtr-3#lip-50.50.50.1#rip-10.20.1.2#lteid-0#rteid-484
    SESSION ID [44] 22 ABDE1B0000001B67FBC0E1




234 2025/04/13 15:49:21.614 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 42
UDP Hdr: Src: 2123, Dst: 2123, Len: 22
GTPv2 Hdr: Len: 14, Seq: 0,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 10.20.1.2 | Rx: Echo Resp
  [RECOVERY]               : 1
  [152]                    : Len: 1 Val: 00

235 2025/04/13 15:49:21.622 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Receive
  Access-Accept(2) id 10 len 152 from 100.0.0.2:1812 vrid 3 pol FreeRadius-auth
    VSA [26] 7 Nokia(6527)
      INTERFACE [101] 5 grp-1
    VSA [26] 9 Nokia(6527)
      SUBSC PROF STR [12] 7 sub-fwa
    VSA [26] 9 Nokia(6527)
      SLA PROF STR [13] 7 sla-fwa
    VSA [26] 6 Nokia(6527)
      SERVICE ID [100] 4 51
    FRAMED IP ADDRESS [8] 4 180.0.0.1
    VSA [26] 23 Nokia(6527)
      SUBSCRIBER QOS OVERRIDE [126] 21 i:p:1:pir=60000,cir=0
    VSA [26] 17 Nokia(6527)
      SUBSCRIBER QOS OVERRIDE [126] 15 e:r:rate=110000
    VSA [26] 6 Nokia(6527)
      INT DEST ID STR [28] 4 eNB1
    CLASS [25] 5 0x7573657231





236 2025/04/13 15:49:21.624 CEST warning: SVCMGR #2500 Base Subscriber created
Subscriber 206010000000001 has been created in the system

237 2025/04/13 15:49:21.624 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Transmit
  Accounting-Request(4) 100.0.0.2:1813 id 66 len 462 vrid 3 pol FreeRadius-acct
    STATUS TYPE [40] 4 Start(1)
    NAS IP ADDRESS [4] 4 192.0.2.11
    USER NAME [1] 15 206010000000001
    FRAMED IP ADDRESS [8] 4 180.0.0.1
    FRAMED IP NETMASK [9] 4 255.255.255.255
    CLASS [25] 5 0x7573657231
    CALLED STATION ID [30] 8 internet
    NAS IDENTIFIER [32] 4 MAG2
    SESSION ID [44] 22 ABDE1B0000001B67FBC0E1
    MULTI SESSION ID [50] 22 ABDE1B0000001D67FBC0E1
    EVENT TIMESTAMP [55] 4 1744552161
    NAS PORT TYPE [61] 4 Virtual(5)
    NAS PORT ID [87] 62 GTP rtr-3#lip-50.50.50.1#rip-10.20.1.2#lteid-1310720#rteid-484
    VSA [26] 35 Nokia(6527)
      SUBSC ID STR [11] 15 206010000000001
      SUBSC PROF STR [12] 7 sub-fwa
      SLA PROF STR [13] 7 sla-fwa
    VSA [241.26] 3 Nokia(6527)
      SPI SHARING_ID [47] 3 SAP
    VSA [26] 19 Nokia(6527)
      CHADDR [27] 17 00:03:00:14:00:05
    DELAY TIME [41] 4 0
    AUTHENTIC [45] 4 RADIUS(1)
    VSA [26] 35 3GPP(10415)
      IMEISV [20] 16 3534900698733153
      IMSI [1] 15 206010000000001
    VSA [26] 29 Nokia(6527)
      WLAN APN NAME [146] 27 internet.mnc001.mcc206.gprs
    VSA [26] 15 3GPP(10415)
      USER LOCATION INFO [22] 13 TAI-ECGI 0x02f610000102f61000000101
    VSA [241.26] 60 Nokia(6527)
      GTP BEARER FTEID [56] 60 rtr-3#bid-5#lip-50.50.50.1#rip-0.0.0.0#lteid-1310725#rteid-0

  


238 2025/04/13 15:49:21.624 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 170
UDP Hdr: Src: 2123, Dst: 2123, Len: 150
GTPv2 Hdr: Len: 138, Seq: 25, TEID: 0x1e4
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Create Session Resp
  [CAUSE]                  : SUCCESS
  [RECOVERY]               : 1
  [S11/S4-C SGW F-TEID]    : 0x0000000a IPv4: 50.50.50.1
  [S5/S8-C PGW F-TEID]     : 0x00140000 IPv4: 50.50.50.1
  [APN RESTRICTION]        : No Context/Restriction
  [PDN ADDR ALLOC]         : IPv4 180.0.0.1
  [AMBR]                   : UL: 60000 kbps, DL: 110000 kbps
  [BEARER CXT]             : Add :0x5 Cause: SUCCESS
      Bearer Qos:  PVI: 0x00 PL: 0x01 PCI: 0x40 QCI: 0x09
      MBR: UL: 0 kbps, DL: 0 kbps GMBR: UL: 0 kbps, DL: 0 kbps
      [S1-U SGW F-TEID]    : 0x00140005 IPv4: 50.50.50.1
      [S5/S8-U PGW F-TEID] : 0x00140005 IPv4: 50.50.50.1

239 2025/04/13 15:49:21.629 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Receive
  Accounting-Response(5) id 66 len 20 from 100.0.0.2:1813 vrid 3 pol FreeRadius-acct





240 2025/04/13 15:49:21.880 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 62
UDP Hdr: Src: 2123, Dst: 2123, Len: 42
GTPv2 Hdr: Len: 30, Seq: 26, TEID: 0xa
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Modify Bearer Req
  [BEARER CXT]             : Add :0x5
      [S1-U eNB F-TEID]    : 0x00000001 IPv4: 10.60.1.11

241 2025/04/13 15:49:21.882 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 79
UDP Hdr: Src: 2123, Dst: 2123, Len: 59
GTPv2 Hdr: Len: 47, Seq: 26, TEID: 0x1e4
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Modify Bearer Resp
  [CAUSE]                  : SUCCESS
  [RECOVERY]               : 1
  [BEARER CXT]             : Add :0x5 Cause: SUCCESS
      [S1-U SGW F-TEID]    : 0x00140005 IPv4: 50.50.50.1

[/]
```


### 1.5 **Checking the FWA 4G home-user**

You can check the 4G FWA home-user VM that tun_srsue is created with the 4G FWA home-user IP 180.0.0.1/24.
```bash
[root@compute-1 scripts]# docker exec -it integrated-ue1 bash
root@ue1:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
13: tun_srsue: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 180.0.0.1/24 scope global tun_srsue
       valid_lft forever preferred_lft forever
2633: eth0@if2634: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:29:0d brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.41.13/24 brd 192.168.41.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:290d/64 scope link
       valid_lft forever preferred_lft forever
2656: eth1@if2655: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:33:60:6f brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.70.1.3/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe33:606f/64 scope link
       valid_lft forever preferred_lft forever

```

When the eNB does not detect data traffic for the session, it initiates the idling procedure on which the 4G FWA session on the MAG enters an idle state.
This is noticed in the below trace. 

```bash
A:admin@MAG2# show s-fwa

===============================================================================
Peers
===============================================================================
Host identity                          Status        Default Preference Active
-------------------------------------------------------------------------------
pcrf.localdomain                       I-Open        No      50         Yes
-------------------------------------------------------------------------------
No. of peers: 1
===============================================================================

===============================================================================
Peer "pcrf.localdomain"
===============================================================================
Index                       : 1
Status                      : I-Open
Administrative state        : enabled
Active                      : Yes
Active applications         : (relay)
Last disconnect cause       : rebooting
Preference                  : 50
Default peer                : No
Connection timer (s)        : N/A
Watchdog timer (s)          : 3
Pending messages            : 0
Remote realm                : localdomain
Remote IP address           : 10.30.1.4
Remote TCP port             : 3868
Remote Origin-State-Id      : 1744116020
Local host identity         : bng.localdomain
Local realm                 : localdomain
Local IP address            : 50.50.50.1
Local TCP port              : 51850
Last management change      : 04/07/2025 20:57:18
===============================================================================

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- 206010000000001
   (sub-fwa)
   |
   +-- sap:[pxc-7.b:1.8] - sla:sla-fwa
       |
       +-- IPOE-session - mac:00:03:00:18:00:05 - svc:51
           |
           +-- 180.0.0.1 - GTP

-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================

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
Time                        : 2025/04/13 16:03:04

-------------------------------------------------------------------------------
No. of Peers: 1
===============================================================================

===============================================================================
GTP system summary
===============================================================================
Actual number of MME                                    : 1
Actual number of ENODE-B                                : 0
Actual number of S11 Sessions                           : 1
Actual number of S11 Idle Sessions                      : 1
Actual number of Mobile Gateways                        : 0
Actual number of Uplinks                                : 0
Actual number of Uplinks in Hold                        : 0
===============================================================================

===============================================================================
GTP S11 sessions
===============================================================================
IMSI                        : 206010000000001
APN                         : internet.mnc001.mcc206.gprs
-------------------------------------------------------------------------------
Peer router                 : 2043
Peer address                : 10.20.1.2
Remote control TEID         : 255
Local control TEID          : 12
PDN TEID                    : 1572864
Charging characteristics    : (None)
Uplink AMBR (kbps)          : 60000
Downlink AMBR (kbps)        : 110000
User Location Info - TAI    : MCC:206 MNC:01 TAC:0001
User Location Info - ECGI   : MCC:206 MNC:01 ECI:0000101
Ipoe-session SAP            : [pxc-7.b:1.8]
Ipoe-session Mac Address    : 00:03:00:18:00:05
Bearer 5
  Rem S1-U address          : 0.0.0.0
  rem TEID                  : 0
  loc TEID                  : 1572869
  uplink GBR (kbps)         : 0
  uplink MBR (kbps)         : 0
  downlink GBR (kbps)       : 0
  downlink MBR (kbps)       : 0
  QoS Class ID              : 9
  alloc/ret priority        : 1
```

Also can be checked via the UE1.log
```bash
Found Cell:  Mode=FDD, PCI=1, PRB=50, Ports=1, CP=Normal, CFO=0.0 KHz
Found PLMN:  Id=20601, TAC=1
Random Access Transmission: seq=9, tti=981, ra-rnti=0x2
RRC Connected
Random Access Complete.     c-rnti=0x46, ta=0
Network attach successful. IP: 180.0.0.1
 nTp) ((t) 13/4/2025 14:3:2 TZ:0
Received RRC Connection Release (releaseCause: other)
RRC IDLE
```


### 1.6 **Checking the dataplane**

The 4G FWA home-user can reach the internet VRF 500 on TRA via the tun_srsue.
```bash
root@ue1:/# ip r
default via 192.168.41.1 dev eth0
1.1.1.0/24 dev tun_srsue scope link
10.70.1.0/24 dev eth1 proto kernel scope link src 10.70.1.3
180.0.0.0/24 dev tun_srsue proto kernel scope link src 180.0.0.1
192.168.41.0/24 dev eth0 proto kernel scope link src 192.168.41.13
```bash

root@ue1:/# ping 1.1.1.201
PING 1.1.1.201 (1.1.1.201) 56(84) bytes of data.
64 bytes from 1.1.1.201: icmp_seq=1 ttl=63 time=320 ms
64 bytes from 1.1.1.201: icmp_seq=2 ttl=63 time=431 ms
64 bytes from 1.1.1.201: icmp_seq=3 ttl=63 time=299 ms
```


Also you can ping the 4G FWA home-user from the TRA via a predefined script.

```bash
A:admin@TRA-integrated# show ping-fwa
PING 180.0.0.1 56 data bytes
64 bytes from 180.0.0.1: icmp_seq=1 ttl=63 time=50.4ms.
64 bytes from 180.0.0.1: icmp_seq=2 ttl=63 time=30.1ms.
64 bytes from 180.0.0.1: icmp_seq=3 ttl=63 time=33.4ms.
64 bytes from 180.0.0.1: icmp_seq=4 ttl=63 time=38.8ms.
64 bytes from 180.0.0.1: icmp_seq=5 ttl=63 time=45.8ms.
```
The ping will trigger the paging procedure on which the bearer between eNB and MAG will be activated again. 
This is noticed in the below trace

```bash
336 2025/04/13 16:13:03.952 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 41
UDP Hdr: Src: 2123, Dst: 2123, Len: 21
GTPv2 Hdr: Len: 9, Seq: 10,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Echo Req
  [RECOVERY]               : 1
337 2025/04/13 16:13:03.954 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 42
UDP Hdr: Src: 2123, Dst: 2123, Len: 22
GTPv2 Hdr: Len: 14, Seq: 10,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 10.20.1.2 | Rx: Echo Resp
  [RECOVERY]               : 1
  [152]                    : Len: 1 Val: 00
338 2025/04/13 16:14:03.952 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 41
UDP Hdr: Src: 2123, Dst: 2123, Len: 21
GTPv2 Hdr: Len: 9, Seq: 11,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Echo Req
  [RECOVERY]               : 1
339 2025/04/13 16:14:03.954 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 42
UDP Hdr: Src: 2123, Dst: 2123, Len: 22
GTPv2 Hdr: Len: 14, Seq: 11,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 10.20.1.2 | Rx: Echo Resp
  [RECOVERY]               : 1
  [152]                    : Len: 1 Val: 00
340 2025/04/13 16:15:03.952 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 41
UDP Hdr: Src: 2123, Dst: 2123, Len: 21
GTPv2 Hdr: Len: 9, Seq: 12,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Echo Req
  [RECOVERY]               : 1
341 2025/04/13 16:15:03.955 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 42
UDP Hdr: Src: 2123, Dst: 2123, Len: 22
GTPv2 Hdr: Len: 14, Seq: 12,
GID: 1 | GRP: 1 | I:*** | A:*** | S11-C: 10.20.1.2 | Rx: Echo Resp
  [RECOVERY]               : 1
  [152]                    : Len: 1 Val: 00
342 2025/04/13 16:15:04.425 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 84
UDP Hdr: Src: 2123, Dst: 2123, Len: 64
GTPv2 Hdr: Len: 52, Seq: 38, TEID: 0xc
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Modify Bearer Req
  [USER LOCATION INFO]     : TAI + ECGI: 02 f6 10 00 01 02 f6 10 00 00 01 01 01 00
  [DELAY VALUE]            : 0
  [BEARER CXT]             : Add :0x5
      [S1-U eNB F-TEID]    : 0x00000002 IPv4: 10.60.1.11
343 2025/04/13 16:15:04.427 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 79
UDP Hdr: Src: 2123, Dst: 2123, Len: 59
GTPv2 Hdr: Len: 47, Seq: 38, TEID: 0xff
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Modify Bearer Resp
  [CAUSE]                  : SUCCESS
  [RECOVERY]               : 1
  [BEARER CXT]             : Add :0x5 Cause: SUCCESS
      [S1-U SGW F-TEID]    : 0x00180005 IPv4: 50.50.50.1
[/]
```

```bash
A:admin@MAG2# show s-fwa
===============================================================================
Peers
===============================================================================
Host identity                          Status        Default Preference Active
-------------------------------------------------------------------------------
pcrf.localdomain                       I-Open        No      50         Yes
-------------------------------------------------------------------------------
No. of peers: 1
===============================================================================

===============================================================================
Peer "pcrf.localdomain"
===============================================================================
Index                       : 1
Status                      : I-Open
Administrative state        : enabled
Active                      : Yes
Active applications         : (relay)
Last disconnect cause       : rebooting
Preference                  : 50
Default peer                : No
Connection timer (s)        : N/A
Watchdog timer (s)          : 4
Pending messages            : 0
Remote realm                : localdomain
Remote IP address           : 10.30.1.4
Remote TCP port             : 3868
Remote Origin-State-Id      : 1744116020
Local host identity         : bng.localdomain
Local realm                 : localdomain
Local IP address            : 50.50.50.1
Local TCP port              : 51850
Last management change      : 04/07/2025 20:57:18
===============================================================================
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- 206010000000001
   (sub-fwa)
   |
   +-- sap:[pxc-7.b:1.8] - sla:sla-fwa
       |
       +-- IPOE-session - mac:00:03:00:18:00:05 - svc:51
           |
           +-- 180.0.0.1 - GTP

-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
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
Time                        : 2025/04/13 16:03:04

-------------------------------------------------------------------------------
No. of Peers: 1
===============================================================================
===============================================================================
GTP system summary
===============================================================================
Actual number of MME                                    : 1
Actual number of ENODE-B                                : 1
Actual number of S11 Sessions                           : 1
Actual number of S11 Idle Sessions                      : 0
Actual number of Mobile Gateways                        : 0
Actual number of Uplinks                                : 0
Actual number of Uplinks in Hold                        : 0
===============================================================================
===============================================================================
GTP S11 sessions
===============================================================================
IMSI                        : 206010000000001
APN                         : internet.mnc001.mcc206.gprs
-------------------------------------------------------------------------------
Peer router                 : 2043
Peer address                : 10.20.1.2
Remote control TEID         : 255
Local control TEID          : 12
PDN TEID                    : 1572864
Charging characteristics    : (None)
Uplink AMBR (kbps)          : 60000
Downlink AMBR (kbps)        : 110000
User Location Info - TAI    : MCC:206 MNC:01 TAC:0001
User Location Info - ECGI   : MCC:206 MNC:01 ECI:0000101
Ipoe-session SAP            : [pxc-7.b:1.8]
Ipoe-session Mac Address    : 00:03:00:18:00:05
Bearer 5
  Rem S1-U address          : 10.60.1.11
  rem TEID                  : 2
  loc TEID                  : 1572869
  uplink GBR (kbps)         : 0
  uplink MBR (kbps)         : 0
  downlink GBR (kbps)       : 0
  downlink MBR (kbps)       : 0
  QoS Class ID              : 9
  alloc/ret priority        : 1

-------------------------------------------------------------------------------
No. of GTP S11 sessions: 1
===============================================================================
===============================================================================
GTP statistics
===============================================================================
tx echo requests                                        : 319
rx echo responses                                       : 311
path faults                                             : 1
tx create session responses                             : 12
tx delete session responses                             : 10
tx delete bearer requests                               : 2
tx modify bearer responses                              : 18
tx rls access bearers responses                         : 15
tx downlink notifications                               : 4
rx create session requests                              : 12
rx delete session requests                              : 10
rx modify bearer requests                               : 18
rx rls access bearers request                           : 15
rx unknown pkts                                         : 4
rx discarded pkts                                       : 7
rx pkts                                                 : 373
tx pkts                                                 : 383
===============================================================================
===============================================================================
Subscriber Management Statistics for System
===============================================================================
       Type                                Current     Peak      Peak Timestamp
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   IPOE Mngd Hosts  - GTP                    1        1 04/13/2025 16:15:44
-------------------------------------------------------------------------------
Total  IPOE Hosts                                1        1 04/13/2025 16:15:44
       IPv4 Hosts                                1        1 04/13/2025 16:15:44
       System Hosts Scale                        1        1 04/13/2025 16:15:44
-------------------------------------------------------------------------------
===============================================================================
Peak values last reset at : 04/13/2025 16:15:44
===============================================================================
SLA Profile Statistics
===============================================================================
SLA-Profile Name                           Current     Peak      Peak Timestamp
-------------------------------------------------------------------------------
sla-default                                      0        0
sla-fwa                                          1        1 04/08/2025 11:06:13
sla-ipoe                                         0       10 04/08/2025 17:06:39
sla-pppoe                                        0       10 04/08/2025 11:06:25
-------------------------------------------------------------------------------
Total                                            1
===============================================================================
```
Also can be checked via the UE1.log.

```bash
Found Cell:  Mode=FDD, PCI=1, PRB=50, Ports=1, CP=Normal, CFO=0.0 KHz
Found PLMN:  Id=20601, TAC=1
Random Access Transmission: seq=9, tti=981, ra-rnti=0x2
RRC Connected
Random Access Complete.     c-rnti=0x46, ta=0
Network attach successful. IP: 180.0.0.1
 nTp) ((t) 13/4/2025 14:3:2 TZ:0
Received RRC Connection Release (releaseCause: other)
RRC IDLE
Service Request with cause mo-Data.
Random Access Transmission: seq=14, tti=651, ra-rnti=0x2
RRC Connected
Random Access Complete.     c-rnti=0x47, ta=0
Service Request successful.
```

### 1.7 **Stopping the 4G session**

You can stop the 4G session using the predefined script below.
Note, however, that the `./stop_4g_bng.sh` script does not initiate a release procedure towards the network.
The release procedure, followed by the creation of a new session, will be triggered during the next run of `./start_4g_bng.sh`.
Alternatively, the session can also be cleared directly from the MAG.

```bash
[root@compute-1 scripts]# ./stop_4g_bng.sh
Stopping eNodeB and 4G FWA home-user processes...
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

Also a clear command from MAG can be executed.

```bash
A:admin@MAG2# clear fwa
Executed 5 lines in 0.0 seconds from file "cf1:\scripts-md\clear-fwa"

290 2025/04/13 16:01:26.693 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 51
UDP Hdr: Src: 2123, Dst: 2123, Len: 31
GTPv2 Hdr: Len: 19, Seq: 1, TEID: 0x25
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Delete Bearer Req
  [EBI]                    : 0x5
  [CAUSE]                  : SUCCESS

291 2025/04/13 16:01:27.025 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 84
UDP Hdr: Src: 2123, Dst: 2123, Len: 64
GTPv2 Hdr: Len: 52, Seq: 33, TEID: 0xb
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Modify Bearer Req
  [USER LOCATION INFO]     : TAI + ECGI: 02 f6 10 00 01 02 f6 10 00 00 01 01 00 00
  [DELAY VALUE]            : 0
  [BEARER CXT]             : Add :0x5
      [S1-U eNB F-TEID]    : 0x00000002 IPv4: 10.60.1.11

292 2025/04/13 16:01:27.025 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 51
UDP Hdr: Src: 2123, Dst: 2123, Len: 31
GTPv2 Hdr: Len: 19, Seq: 33, TEID: 0x25
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Modify Bearer Resp
  [CAUSE]                  : CONTEXT_NOT_FOUND
  [RECOVERY]               : 1

293 2025/04/13 16:01:27.025 CEST warning: WLAN_GW #2020 Base GTP
GTP ingress message (type 34 version gtpv2C IMSI 206010000000001 TEID 11) dropped from/to GTP Peer 10.20.1.2 port 2123 in router vprn2043 - Unexpected GTP message

294 2025/04/13 16:01:27.028 CEST minor: DEBUG #2001 vprn2043 GTP
GTP: GTPv2_INGRESS
IP Hdr: Src: 10.20.1.2, Dst: 50.50.50.1, Len: 76
UDP Hdr: Src: 2123, Dst: 2123, Len: 56
GTPv2 Hdr: Len: 44, Seq: 34, TEID: 0xb
GTPv2_INGRESS| S11-C: 10.20.1.2 | Rx: Delete Session Req
  [EBI]                    : 0x5
  [USER LOCATION INFO]     : TAI + ECGI: 02 f6 10 00 01 02 f6 10 00 00 01 01 00 00
  [INDICATION]             : 0x08000000000000000000

295 2025/04/13 16:01:27.029 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Transmit
  Accounting-Request(4) 100.0.0.2:1813 id 70 len 658 vrid 3 pol FreeRadius-acct
    STATUS TYPE [40] 4 Stop(2)
    NAS IP ADDRESS [4] 4 192.0.2.11
    USER NAME [1] 15 206010000000001
    FRAMED IP ADDRESS [8] 4 180.0.0.1
    FRAMED IP NETMASK [9] 4 255.255.255.255
    CLASS [25] 5 0x7573657231
    CALLED STATION ID [30] 8 internet
    NAS IDENTIFIER [32] 4 MAG2
    SESSION ID [44] 22 ABDE1B0000001E67FBC386
    SESSION TIME [46] 4 49
    TERMINATE CAUSE [49] 4 User Request(1)
    VSA [26] 37 Nokia(6527)
      ERROR CODE [226] 4 275
      ERROR MESSAGE [227] 29 GTP user initiated disconnect
    MULTI SESSION ID [50] 22 ABDE1B0000002067FBC386
    EVENT TIMESTAMP [55] 4 1744552887
    NAS PORT TYPE [61] 4 Virtual(5)
    NAS PORT ID [87] 61 GTP rtr-3#lip-50.50.50.1#rip-10.20.1.2#lteid-1441792#rteid-37
    VSA [26] 35 Nokia(6527)
      SUBSC ID STR [11] 15 206010000000001
      SUBSC PROF STR [12] 7 sub-fwa
      SLA PROF STR [13] 7 sla-fwa
    VSA [241.26] 3 Nokia(6527)
      SPI SHARING_ID [47] 3 SAP
    VSA [26] 19 Nokia(6527)
      CHADDR [27] 17 00:03:00:16:00:05
    DELAY TIME [41] 4 0
    AUTHENTIC [45] 4 RADIUS(1)
    VSA [26] 35 3GPP(10415)
      IMEISV [20] 16 3534900698733153
      IMSI [1] 15 206010000000001
    VSA [26] 29 Nokia(6527)
      WLAN APN NAME [146] 27 internet.mnc001.mcc206.gprs
    VSA [26] 15 3GPP(10415)
      USER LOCATION INFO [22] 13 TAI-ECGI 0x02f610000102f61000000101
    VSA [241.26] 60 Nokia(6527)
      GTP BEARER FTEID [56] 60 rtr-3#bid-5#lip-50.50.50.1#rip-0.0.0.0#lteid-1441797#rteid-0
    INPUT PACKETS [47] 4 0
    INPUT OCTETS [42] 4 0
    OUTPUT PACKETS [48] 4 0
    OUTPUT OCTETS [43] 4 0
    VSA [26] 112 Nokia(6527)
      INPUT V6 PACKETS [194] 4 0
      INPUT V6 OCTETS [195] 4 0
      OUTPUT V6 PACKETS [197] 4 0
      OUTPUT V6 OCTETS [198] 4 0
      OUTPUT_INPROF_OCTETS_64 [21] 10 0x00010000000000000000
      OUTPUT_OUTPROF_OCTETS_64 [22] 10 0x00010000000000000000
      OUTPUT_INPROF_PACKETS_64 [25] 10 0x00010000000000000000
      OUTPUT_OUTPROF_PACKETS_64 [26] 10 0x00010000000000000000
      INPUT_STATMODE [107] 14 0x8001 minimal
      INPUT_ALL_OCTETS_64 [116] 10 0x80010000000000000000
      INPUT_ALL_PACKETS_64 [118] 10 0x80010000000000000000
297 2025/04/13 16:01:27.029 CEST minor: DEBUG #2001 vprn2043 GTP
GTP:  GTPv2_EGRESS
IP Hdr: Src: 50.50.50.1, Dst: 10.20.1.2, Len: 51
UDP Hdr: Src: 2123, Dst: 2123, Len: 31
GTPv2 Hdr: Len: 19, Seq: 34, TEID: 0x25
I:*** | A:*** | S11-C: 50.50.50.1 | Tx: Delete Session Resp
  [CAUSE]                  : SUCCESS
  [RECOVERY]               : 1

298 2025/04/13 16:01:27.029 CEST warning: SVCMGR #2501 Base Subscriber deleted
Subscriber 206010000000001 has been removed from the system

299 2025/04/13 16:01:27.030 CEST minor: WLAN_GW #2009 Base CPM-GTP
The state of the GTP Peer 10.20.1.2 port 2123 in router vprn2043 has changed to idle.

300 2025/04/13 16:01:27.030 CEST minor: WLAN_GW #2006 Base CPM-GTP
Connection interrupted with GTP Peer 10.20.1.2 port 2123 in router vprn2043.

301 2025/04/13 16:01:27.034 CEST minor: DEBUG #2001 vprn2043 RADIUS
RADIUS: Receive
  Accounting-Response(5) id 70 len 20 from 100.0.0.2:1813 vrid 3 pol FreeRadius-acct
[/]
```



