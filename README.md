# MAG-Integrated: 4G Non-CUPS Simulation using Open5GS, srsRANSim, BNGBlaster, and ContainerLab

**MAG-Integrated** is an open-source project that simulates a **4G Non-CUPS (Centralized User Plane Separation)** network architecture. This project utilizes **ContainerLab** for container-based network simulation, **Open5GS** for the core network, **srsRANSim** for simulating the radio components (eNB and UE), and **BNGBlaster** for broadband access emulation using **PPPoE** and **IPoE**.

## Overview

This project is designed to simulate a 4G mobile network without the need for centralized user plane separation (CUPS). It integrates **Open5GS** as the core network solution and uses **BNGBlaster** to simulate broadband access via PPPoE and IPoE. The entire network is deployed in a containerized environment using **ContainerLab**, enabling rapid setup and flexible testing of network configurations.

The goal of this project is to provide an efficient, scalable, and flexible way to simulate a 4G Non-CUPS network using open-source tools.

## Features

- **Containerized Simulation**: Uses **ContainerLab** for efficient deployment and orchestration of network components.
- **Open5GS**: Implements an open-source 4G core network with key elements such as MME (Mobility Management Entity), HSS (Home Subscriber Server), and PCRF (Policy and Charging Rules Function).
- **PPPoE/IPoE Simulation**: Enables broadband access testing with **BNGBlaster**.
- **Flexible Setup**: Customizable network topology and components.
- **Open Source**: Suitable for research, testing, and educational purposes.

## Components

### 1. **ContainerLab**
   - **ContainerLab** is used to simulate network components in isolated containers, making the environment lightweight and manageable.
   - It orchestrates network elements, including **Open5GS**, **BNGBlaster**, and **srsRANSim**.

### 2. **Open5GS**
   - **Open5GS** provides the **Evolved Packet Core (EPC)** components, such as **MME**, **HSS**, and **PCRF**.
   - Configured in **Non-CUPS** mode, meaning the control and user planes are not separated.

### 3. **BNGBlaster**
   - Simulates **PPPoE** and **IPoE** sessions for broadband access testing.

### 4. **srsRANSim** 
   - Provides an open-source LTE/5G software radio stack.
   - Simulates **UE** and **eNB/gNB**, facilitating mobile network emulation.

### 5. **FreeRADIUS**
  - An open-source **RADIUS server** for Authentication, Authorization, and Accounting (AAA).
  - Supports **EAP, PAP, CHAP** and integrates with **MySQL, PostgreSQL, and LDAP**.
  - Used in ISPs and telecom networks for network access control.

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

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/htakkey/cups-integrated.git
   cd cups-integrated
   ```
   
2. **Deploy the ContainerLab Setup**:
   ```bash   
   clab deploy -t mag-integrated.clab.yml
   ```
   
3. **Register the 4G Subscriber**:

   Use this script to register the **IMSI** with a specific apn,opc,key,sst and sd.
   ```bash
   [root@compute-1 scripts]# ./register_subscriber.sh 
   ```

4. **Start Open5GS Components**:
   ```bash
   cd scripts
   ./start_open5gs.sh
   ```
   - Starts **HSS** and **MME**.

##### **4.1 GUI Access to the Database**

📌 **URL**: `http://x.x.x.x:9999/`  
📌 **Username/Password**: `admin/1423`  

![Database View](images/Database.png)

5. **Start the 4G Network Session**:

![Network Topology](images/4g-non-cups.png)

   ```bash
   cd scripts
   ./start_4g_bng.sh
   ```
  
6. **Start an IPoE/PPPoE Session using BNGBlaster**:
   ```bash
   cd scripts
   ./start_dhcp_bng.sh
   ./start_pppoe_bng_traffic.sh   ## (Starts session with traffic)
   ```
    
---

## **License**
- **ContainerLab images for VSR** are provided by **Nokia** and require a commercial license.
- **Other ContainerLab images** (Open5GS, FreeRADIUS, srsRANSim) are publicly available.

---

## **Contributing**
Contributions are welcome! Submit a **pull request** or open an **issue** to report bugs or suggest improvements.

---

## **Contact**
For inquiries, reach out via **GitHub issues** or contact the **Nokia team** for commercial licensing details.
