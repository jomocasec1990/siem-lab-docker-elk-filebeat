# 🧠 Cortex Lab - Elasticsearch + Cortex Setup

This document covers the full process of preparing **Elasticsearch** and installing **Cortex** in a SOC lab environment. This setup enables automated analysis workflows using Cortex with Elasticsearch as its backend.

---

## 🧰 Lab Objectives

- ✅ Install and configure Elasticsearch as the backend for Cortex.
- ✅ Add the required repositories and keys.
- ✅ Install and configure Cortex to connect to the Elasticsearch instance.
- ✅ Verify that both services are up and communicating correctly.

---

## 📦 1. Install Java and Elasticsearch

```bash
sudo apt update
sudo apt install openjdk-11-jre-headless -y
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
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: []
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
play.http.secret.key="6uZA3OFfAtPggbVYQSS07Lo4zncb636hP6yepsnDgvKnmNYBznn4kRAjVUXe9wDm"
_EOF_
) | sudo tee -a /etc/cortex/application.conf
```

---

## 🚀 6. Start Cortex

```bash
sudo systemctl start cortex
sudo systemctl status cortex
```

Expected output:

```bash
● cortex.service - cortex
     Loaded: loaded (...)
     Active: active (running)
```

---

## 🧪 7. Port Verification

Make sure both services are up:

```bash
ss -tuln | grep 9200
ss -tuln | grep 9001
```

---

## 📎 Notes

- Elasticsearch must be reachable from the Cortex host.
- If deploying Cortex in a distributed environment, reuse the same `play.http.secret.key`.
