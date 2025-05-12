
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
| **Part 1** | [ELK Stack & Filebeat Setup](./README.md) – Deploy Elasticsearch, Kibana, Filebeat via Docker. |
| **Part 2** | [MISP Deployment & Threat Intelligence Workflow](./misp/README.md) – Install MISP, create events, tags, galaxies, attributes & objects. |
| **Part 3** | [Cortex Installation & TheHive Integration](./cortex/README.md) – Install Cortex, configure analyzers, integrate with TheHive. |
| **Part 4** | [TheHive Setup for Incident Response](./thehive/README.md) – Case management setup, users, profiles, organizations. |
| **Part 5** | [TheHive Integration with Elasticsearch - Webhook Alerts](./thehiveintegration/README.md) – Send alerts from SIEM to TheHive using API webhooks. |

---

## 🧰 Technologies Used

- **Docker & Docker Compose**
- **Elasticsearch, Kibana, Filebeat**
- **MISP (Malware Information Sharing Platform)**
- **Cortex (for automated enrichment & response)**
- **TheHive (case management & alerting)**
- **Python (MISP API automation)**

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
SOC Engineer & Threat Intel Lab Developer  
GitHub: [@jomocasec1990](https://github.com/jomocasec1990)
