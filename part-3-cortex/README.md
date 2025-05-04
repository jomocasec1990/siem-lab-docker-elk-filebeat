
# 🧠 Cortex Lab - Full Installation 

This document explains the full installation process of **Elasticsearch** and **Cortex** for a Security Operations Center (SOC) lab setup. It includes the core setup and optional configuration for local analyzers.

---

## 🧰 Lab Overview

- OS: Ubuntu 20.04.6 LTS (x86_64)
- Cortex Version: 3.1.8-1
- Elasticsearch Version: 7.x
- IP Address: 192.168.0.102
- Analyzer Path: /opt/cortex/Cortex-Analyzers/analyzers

---

## 📦 1. Install Java and Elasticsearch

```bash
sudo apt update
sudo apt install openjdk-8-jre-headless -y
```

Add Elasticsearch GPG key and repository:

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
```

Install Elasticsearch:

```bash
sudo apt install elasticsearch -y
```

---

## ⚙️ 2. Configure Elasticsearch

Edit the Elasticsearch config file:

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

Apply the following configuration:

```yaml
network.host: 0.0.0.0 -> Private IP
http.port: 9200
discovery.seed_hosts: ["host1, "host2"]
node.name: node1
cluster.initial_master_nodes: ["node1"]
cluster.name: hive
thread_pool.search.queue_size: 100000
```

---

## ▶️ 3. Start Elasticsearch

```bash
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
```

---

## 🛠️ 4. Install Cortex

Add the GPG key and repository:

```bash
wget -qO- https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo gpg --dearmor -o /usr/share/keyrings/thehive-project-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/thehive-project-archive-keyring.gpg] https://deb.thehive-project.org release main" | sudo tee /etc/apt/sources.list.d/thehive-project.list
sudo apt update
```

Install Cortex and dependencies:

```bash
sudo apt install cortex -y
```

---

## ⚙️ 5. Configure Cortex

Go to the configuration directory:

```bash
cd /etc/cortex
```

Edit the `application.conf` file:

```bash
sudo nano application.conf
```

Update the Elasticsearch URI:

```hocon
uri = "http://192.168.0.102:9200"
```

Generate and add a secret key:

```bash
(cat << _EOF_
# Secret key
# ~~~~~~~
# The secret key is used to secure cryptographic functions.
# If you deploy your application to several instances be sure to use the same key!
play.http.secret.key="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"
_EOF_
) | sudo tee -a /etc/cortex/application.conf
```

---

## 🚀 6. Start Cortex

```bash
sudo systemctl start cortex
sudo systemctl enable cortex  # Optional
sudo systemctl status cortex
```

Expected output:

```bash
● cortex.service - cortex
     Loaded: loaded (...)
     Active: active (running)
```

---

## 🔍 7. Verify Listening Ports

```bash
ss -tuln | grep 9200
ss -tuln | grep 9001
```

---

## 🧪 8. Download Cortex Analyzers

To enable automated analysis tasks in Cortex (like scanning IPs, hashes, URLs, etc.), you need to download the official set of analyzer scripts provided by TheHive Project.

```bash
sudo apt-get install -y --no-install-recommends \
  python3-pip python3-dev ssdeep libfuzzy-dev libfuzzy2 \
  libimage-exiftool-perl libmagic1 build-essential git libssl-dev

sudo pip3 install -U pip setuptools

cd /opt/cortex
sudo git clone https://github.com/TheHive-Project/Cortex-Analyzers
```

---

## ⚙️ 9. Install and Configure Analyzers

Install Python dependencies for the analyzers:

```bash
cd /opt/cortex
for I in $(find Cortex-Analyzers -name 'requirements.txt'); do sudo -H pip install -r $I; done
for I in $(find Cortex-Analyzers -name 'requirements.txt'); do sudo -H pip3 install -r $I || true; done
```

Edit `application.conf` and add the local analyzer path:

```bash
sudo nano /etc/cortex/application.conf
```

Add this section:

```hocon
analyzer {
  urls = [
    # "https://download.thehive-project.org/analyzers.json"
    "/opt/cortex/Cortex-Analyzers/analyzers"
  ]
}
```

Restart Cortex to apply changes:

```bash
sudo systemctl restart cortex
sudo systemctl status cortex
```

---

## 📌 Final Notes

- Ensure Elasticsearch is running before starting Cortex.
- Keep the same secret key across Cortex instances in a distributed setup.
- Use local analyzers path to avoid external dependencies if preferred.
