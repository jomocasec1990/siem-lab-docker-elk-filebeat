
# 🧠 Cortex Lab - Part 1: Elasticsearch Setup for Cortex

This is the first part of the hands-on SOC lab focused on installing and preparing **Elasticsearch** for use with **Cortex**.

---

## 📦 1. Install Java and Elasticsearch

```bash
sudo apt update
sudo apt install openjdk-11-jre-headless -y
```

Add the Elasticsearch GPG key:

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```

Add the Elasticsearch repository:

```bash
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
```

Update package index and install:

```bash
sudo apt update
sudo apt install elasticsearch -y
```

---

## ⚙️ 2. Configure Elasticsearch

Edit the Elasticsearch config file:

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

Make sure the following lines are set (add or uncomment if needed):

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

## ▶️ 3. Start and Enable Elasticsearch

```bash
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
```

---

## 🔐 4. Install Cortex and Dependencies

Add Cortex GPG Key and Repository:

```bash
wget -qO- https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo gpg --dearmor -o /usr/share/keyrings/thehive-project-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/thehive-project-archive-keyring.gpg] https://deb.thehive-project.org release main" | sudo tee /etc/apt/sources.list.d/thehive-project.list
sudo apt update
```

Install Cortex:

```bash
sudo apt install cortex -y
```

---

## ⚙️ 5. Cortex Configuration

### Locate Configuration Directory

```bash
cd /etc/cortex
ls
```

Files present:

- `application.conf`
- `logback.xml`

### View and Edit Configuration

```bash
sudo nano /etc/cortex/application.conf
```

Update the Elasticsearch URI to match the correct host (e.g. another VM):

```hocon
uri = "http://192.168.0.102:9200"
```

### Generate and Add Secret Key

Generate key:

```bash
cat << _EOF_
# Secret key
# ~~~~~~~
# The secret key is used to secure cryptographic functions.
# If you deploy your application to several instances be sure to use the same key!
play.http.secret.key="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"
_EOF_
```

Append manually or add directly to the config file:

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

## 🚀 6. Start and Verify Cortex

```bash
sudo systemctl start cortex
sudo systemctl status cortex
```

Expected output:

```
● cortex.service - cortex
     Loaded: loaded (...)
     Active: active (running)
```

---

## 🔍 7. Port Verification

Ensure both services are listening:

```bash
ss -tuln | grep 9200
ss -tuln | grep 9001
```
