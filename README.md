# **MAG-Integrated: ContainerLab leveraging open-source tools like BNGBlaster, Open5GS, and srsRANSim**

## **Overview**

MAG-Integrated is an open-source project built around an integrated Multi-Access Gateway architecture, previously known as a Broadband Network Gateway (BNG). It enables multi-access sessions by handling both fixed (PPPoE and IPoE) and fixed-wireless (4G) connections on a single gateway.

This project leverages Open5GS for the core network, **srsRANSim** for radio components (eNB and 4G sessions), and **FreeRADIUS**, an open-source RADIUS server for Authentication, Authorization, and Accounting (AAA). It also integrates **BNGBlaster** to simulate fixed PPPoE and IPoE sessions and is deployed in a containerized environment using ContainerLab, enabling rapid setup and flexible network testing.

The goal of **MAG-Integrated** is to provide an efficient, flexible environment for simulating fixed and FWA (Fixed Wireless Access) sessions using open-source tools. It is primarily designed for functional testing and educational purposes.

## **Features**
-	**Containerized Simulation**: Uses ContainerLab for efficient deployment and orchestration of network components.
-	**Open5GS**: Implements an open-source EPC (4G) core network with key elements such as **MME** (Mobility Management Entity), **HSS** (Home Subscriber Server), and **PCRF** (Policy and Charging Rules Function).
-	**PPPoE/IPoE Simulation**: Enables broadband access testing with **BNGBlaster**.
-	**Flexible Setup**: Customizable network topology and components.
-	**Open Source**: Suitable for research, testing, and educational purposes.

## **Components**
### **1. MAG-integrated (formally known as Broadband Network Gateway)**
-	**MAG-integrated** (**a.k.a BNG**) is a key network element that connects fixed or fixed wireless users to the network via technologies like DSL, Fiber or Wireless. It handles:
  -	IP Addressing: Assigns IPs to devices.
  -	AAA: Manages authentication, authorization, and accounting.
  -	Traffic Management: Ensures QoS and traffic prioritization.
  -	Session Management: Tracks user sessions.
-	The BNG supports IPoE and PPPoE for broadband access, offering scalability and reliability for service providers.
### **2. ContainerLab**
-	**ContainerLab** is used to simulate network components in isolated containers, making the environment lightweight and manageable.
-	It orchestrates network elements, including **Open5GS**,**BNGBlaster**, and **srsRANSim**.
### **3. Open5GS**
-	Open5GS provides the Evolved Packet Core (EPC) components, such as **MME**, **HSS**, and **PCRF**.
### **4. BNGBlaster**
-	Simulates fixed sessions, like PPPoE and IPoE  for broadband access testing.
### **5. srsRANSim** 
-	Provides an open-source **LTE/5G** software radio stack.
-	Simulates **UE** and **eNB/gNB**, facilitating mobile network emulation.
### **6. FreeRADIUS**
-	An open-source RADIUS server for Authentication, Authorization, and Accounting (AAA).
-	Supports EAP, PAP, CHAP and integrates with MySQL, PostgreSQL, and LDAP.
-	Used in ISPs and telecom networks for network access control.

## Installation

### Prerequisites
Ensure the following dependencies are installed:

- **Docker**: Required for running containerized components.
- **ContainerLab**: For managing container-based network simulations.
- **Git**: For cloning this repository.

---

### **Getting Started**

Follow the **[documentation](docs/installation_verification.md)** for detailed setup instructions.

---

### **Installation Steps**

#### **1. Clone the Repository**

   ```bash
   git clone https://github.com/htakkey/cups-integrated.git
   cd cups-integrated
   ```
#### **2. Create Required Network Bridges**

For **CentOS** (example):
```bash
[root@compute-1 scripts]# ./create_bridges-centos.sh
```
   
#### **3. Deploy the ContainerLab Environment**

Run the following command to deploy the simulated network:
```bash    
clab deploy -t mag-integrated.clab.yml
```

#### **4. cliscripts**
The delivered exec CLI scripts are a collection of standard CLI show commands designed to simplify session monitoring and management during lab upskilling. Instead of manually searching for the exact commands to run, these scripts provide a convenient way to execute them. You should best manually download, transfer and execute them from CF1 of the BNG and TRA.

```bash
[root@compute-1]# pwd
/root/MAG-integrated/cliscripts/
```
#### **5. Register a 5G Subscriber**

Use this script to register the **IMSI** with a specific apn,opc and key
```bash
 root@compute-1 scripts]# ./register_subscriber.sh 
 ```
	
##### **5.1 GUI Access to the Database**
You can verify subscriber records via **Web GUI**:

📌 **URL**: `http://x.x.x.x:9999/' 
📌 **Username/Password**: `admin/1423'  

![Database View](images/Database.png)	

#### **6. Start the Open5GS Core Network**
Run the following script to start the 4G Core( **HSS** and **MME**)
Follow the **[documentation](docs/open5gs_verification.md)** for detailed information/checking .

```bash
[root@compute-1 scripts]# ./start_open5gs.sh
```

#### **7. Start the 4G Session**
Start the 4G session 
Follow the **[documentation](docs/4G_session_verification.md)** for detailed information/checking .

![Network Topology](images/4g-non-cups.png)


```bash
cd scripts
./start_4g_bng.sh
```
#### **8. Start PPPoE/IPoE Session using BNGBlaster**
Start the broadband session using **BNGBlaster**:
Follow the **[documentation](docs/fixed-sessions_verification.md)** for detailed information/checking .

![Fixed Network Topology](images/fixed-bng.png)

```bash
cd scripts
./start_dhcp_bng.sh
./start_pppoe_bng_traffic.sh   ## (Starts session with traffic)
```
![pppoe](images/pppoe.png)
    
---

#### **9. Troubleshooting**

The logs are available for further checking, tcpdump can be used to capture the traffic for any bridge/port
also  there is another option can be integrated with this containerlab is EdgeShark https://containerlab.dev/manual/wireshark/ 
 

![edgeshark](images/edgeshark.png)

---


## **License**
•	ContainerLab images for VSR are provided by Nokia and require a commercial license.
•	All other ContainerLab images like Open5GS, FreeRADIUS or UERANSIM are publicly available and don’t require a license.

------
## **Contributing**
Contributions are welcome! Please submit a **pull request** or open an **issue** if you find bugs or want to improve the project.

---

## **Contact**
For questions, reach out via GitHub issues or contact the **Nokia team** for commercial licensing.

