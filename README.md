# Elastic SIEM Lab - Part 1: Elasticsearch, Kibana, and Filebeat Setup

This project is the first phase of my hands-on Security Information and Event Management (SIEM) lab environment, designed to simulate real-world cybersecurity monitoring and detection workflows. The goal is to build a fully functional SOC (Security Operations Center) lab where logs from various devices and systems are collected, normalized, visualized, and analyzed for threats.

---

## 1. Prerequisites and System Preparation

```bash
sudo apt update
sudo apt install ca-certificates curl gnupg -y

---

## 2. Docker & Docker Compose Installation

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

---

## 3. Docker Compose: Elasticsearch Stack Setup

Created `docker-compose.yml` inside `~/elasticsearch/` with:

```yaml
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.15.0
    ports:
      - "9200:9200"
    environment:
      - discovery.type=single-node

  kibana:
    image: docker.elastic.co/kibana/kibana:7.15.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch

  ent-search:
    image: docker.elastic.co/enterprise-search/enterprise-search:7.15.0
    ports:
      - "3002:3002"
    depends_on:
      - elasticsearch
```

Started the containers:

```bash
sudo docker compose up -d
```

Validated:

```bash
curl http://localhost:9200
ss -tuln | grep 5601
```

Accessed Kibana via browser: `http://192.168.0.100:5601`

---

## 4. Install and Configure Filebeat (on same VM)

### Download and install:

```bash
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.15.0-amd64.deb
sudo dpkg -i filebeat-7.15.0-amd64.deb
```

### Configure Filebeat:

Modified `/etc/filebeat/filebeat.yml`:

```yaml
output.elasticsearch:
  hosts: ["192.168.0.100:9200"]
  protocol: "http"
  username: "elastic"
  password: "Elastic@123"

setup.kibana:
  host: "192.168.0.100:5601"
```

Enabled `system` module:

```bash
cd /etc/filebeat/modules.d/
sudo filebeat modules enable system
```

Started Filebeat:

```bash
sudo service filebeat start
```

---

## 5. Kibana Configuration: Index Pattern

* Accessed `Stack Management > Index Patterns`
* Created index pattern: `filebeat*`
* Selected timestamp field: `@timestamp`

### Final Check

Used `Discover` to validate logs:

* Confirmed Filebeat logs indexed.
* Verified `agent.hostname`, `event.dataset`, `host.ip`, and other fields.

---

## Summary

This completes the first stage of my SIEM lab setup. Everything was tested and configured on VM 192.168.0.100.

---

## Screenshots

### Elasticsearch API Check

![Elasticsearch Running](screenshots/elasticsearch-check.png)

### Kibana Dashboard

![Kibana](screenshots/kibana-dashboard.png)

### Filebeat Index Pattern

![Index Pattern](screenshots/filebeat-index.png)

### Discover Tab

![Logs](screenshots/discover-logs.png)


Next steps will involve shipping logs from other devices and exploring more modules.
