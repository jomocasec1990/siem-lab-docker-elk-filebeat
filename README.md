# 🛡️ Elastic SIEM Lab - Full Environment Setup with Docker, Filebeat & Threat Intelligence

This repository contains a **hands-on cybersecurity lab** designed to simulate a **real-world Security Operations Center (SOC)** environment using **open-source tools** like:

- **Elasticsearch, Kibana, Filebeat** – for log collection and visualization  
- **MISP (Malware Information Sharing Platform)** – for threat intelligence sharing  
- **Cortex** – for automated response and enrichment  
- **TheHive** – for case management and incident tracking  

The goal is to provide **a full detection, investigation, and response pipeline** that replicates the tools and workflow of a modern SOC.

---

## 🧭 Project Structure

Each phase is separated into its own directory with a dedicated `README.md`, step-by-step instructions, configurations, and screenshots.

| Phase | Description |
|-------|-------------|
| 🔹 [`Part 1 - ELK & Filebeat`](./README.md) | Set up Elasticsearch, Kibana, and Filebeat using Docker |
| 🔸 [`Part 2 - MISP`](./misp/README.md) | Install and configure MISP for threat intelligence sharing |
| 🧠 [`Part 3 - Cortex`](./cortext/README.md) | Prepare Elasticsearch and install Cortex for automated analysis |
| 🧾 [`Part 4 - TheHive`](./thehive/) | (Coming Soon) Case management and incident correlation |

---

## 🛠️ Technologies Used

- **Docker & Docker Compose**
- **Linux (Ubuntu)**
- **PowerShell (Hyper-V scripting)**
- **SIEM components**: Elasticsearch, Kibana, Logstash, Filebeat
- **Threat Intel**: MISP
- **Automation & Response**: Cortex
- **Case Management**: TheHive

---

## ⚙️ Lab Deployment Options

This lab can be deployed in various environments:

- ✅ **Local virtual machines (Hyper-V / VirtualBox)**
- ✅ **Cloud virtual machines (Azure / AWS)**
- ✅ **Bare-metal server**

---

## 🧩 Hyper-V Automation (Optional)

If you want to automate the creation of virtual machines on **Hyper-V**, this repository includes a ready-to-use PowerShell script:

### 📄 `Create-Linux-VM.ps1`

This script will:

- Create a Generation 2 VM
- Attach an Ubuntu ISO
- Configure processor, RAM, disk, and network
- Mount ISO and start VM

#### Example usage:

```powershell
.\Create-Linux-VM.ps1 -VMName "SIEM-Ubuntu" -VHDSizeGB 30 -MemoryStartupBytes 4GB -ISOPath "C:\ISOs\ubuntu-22.04.iso"
```

📁 Script location: [`./automation/Create-Linux-VM.ps1`](./automation/Create-Linux-VM.ps1)

---

## 📸 Screenshots

All phases include screenshots and validation outputs in the [`screenshots/`](./screenshots/) folder.

---

## 🧠 Author

**Jordan Moran Cabello**  
TAC Engineer | Cloud Security & SOC Enthusiast  
GitHub: [@jomocasec1990](https://github.com/jomocasec1990)

---

## 🗂️ License

This project is released under the MIT License. Use it freely for learning and internal training.
