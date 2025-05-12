
# 🛡️ SOC Threat Intelligence Lab (Elasticsearch, MISP, Cortex, TheHive)

This repository documents a hands-on cybersecurity lab simulating a **Security Operations Center (SOC) workflow**, using a fully containerized environment with **Elasticsearch, MISP, Cortex, and TheHive**.

You will learn how to **collect, enrich, analyze, and respond to threats** using real-world techniques and open-source tools.

---

## 🎯 Purpose of This Lab

- Build a SOC simulation using open-source technologies.
- Integrate log collection (Filebeat, Elasticsearch, Kibana) with Threat Intelligence (MISP).
- Automate response with Cortex.
- Manage incidents with TheHive.
  
---

## 🗂️ Lab Structure

| Part | Description |
|-------|-------------|
| **Part 1** | [ELK Stack & Filebeat Setup](./01-elk-filebeat/README.md) 
| **Part 2** | [MISP Deployment](./02-misp-setup/README.md) 
| **Part 3** | [Cortex Installation](./03-cortex-setup/README.md) 
| **Part 4** | [TheHive Setup for Incident Response](./04-TheHive-setup/README.md) 
| **Part 5** | [TheHive Integration with Elasticsearch - Webhook Alerts](./05-TheHiveIntegratioin-ELK/README.md) 

---

## 🧰 Technologies Used

- **Docker & Docker Compose**
- **Elasticsearch, Kibana, Filebeat**
- **MISP (Malware Information Sharing Platform)**
- **Cortex (for automated enrichment & response)**
- **TheHive (case management & alerting)**

---

## 🚀 Deployment Options

- Local virtual machines (Hyper-V / VirtualBox)
- Cloud VMs (Azure, AWS)
- Bare-metal servers

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

## 📸 Visual Documentation

Each lab step includes:
- Screenshots
- Command examples
- API requests & responses
- Realistic threat intelligence scenarios

---

## 📝 Author

**Jordan Moran Cabello**  
GitHub: [@jomocasec1990](https://github.com/jomocasec1990)
