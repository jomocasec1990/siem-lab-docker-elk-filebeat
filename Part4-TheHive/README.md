# 🐝 TheHive 4 Installation Lab with Apache Cassandra

This README documents the step-by-step installation and configuration of **TheHive 4** and **Apache Cassandra 4.0** on **Ubuntu 20.04**. The goal is to build a functioning SOC backend capable of storing incidents, observables, and related artifacts with a persistent Cassandra backend.

---

## ✅ System Requirements

- **OS:** Ubuntu 20.04 LTS  
- **RAM:** 4 GB minimum  
- **Java:** OpenJDK 8  
- **Database:** Apache Cassandra 4.0  
- **User Access:** sudo privileges  

---

## 📦 Prepare the System

### Install Java 8 (JRE & JDK)

TheHive requires Java 8 to run. Install it with:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y openjdk-8-jre-headless
sudo apt-get install -y openjdk-8-jdk
```

Check Java version:

```bash
java -version
```

Set the JAVA_HOME environment variable:

```bash
echo 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' | sudo tee -a /etc/environment
```

---

## 🗃️ Apache Cassandra Setup

### Add Repository and GPG Key

We need to add Cassandra’s repository and import the signing key so that APT can verify package integrity:

```bash
echo "deb https://debian.cassandra.apache.org 40x main" | sudo tee /etc/apt/sources.list.d/cassandra.sources.list
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt update
```

### Install and Start Cassandra

Install the Cassandra package and start the service:

```bash
sudo apt install cassandra -y
sudo systemctl start cassandra
sudo systemctl status cassandra
```

### Connect to Cassandra and Set Cluster Name

Use `cqlsh` to access Cassandra and change the cluster name to `thp`:

```bash
cqlsh localhost 9042
UPDATE system.local SET cluster_name = 'thp' WHERE key='local';
exit
```

Flush the change to disk:

```bash
nodetool flush
```

### Configure Cassandra IP Bindings

Edit the Cassandra configuration file to listen on the static IP and restart the service:

```yaml
# /etc/cassandra/cassandra.yaml
cluster_name: 'thp'
          - seeds: "192.168.0.103:7000"
listen_address: 192.168.0.103
rpc_address: 192.168.0.103
```

Restart the service:

```bash
sudo service cassandra restart
```

---

## 🐝 Install TheHive 4

### Add Repository and GPG Key

Add TheHive’s official repo and import the key (APT now uses GPG keyrings):

```bash
curl -s https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo gpg --dearmor -o /usr/share/keyrings/thehive-project-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/thehive-project-archive-keyring.gpg] https://deb.thehive-project.org release main" | sudo tee /etc/apt/sources.list.d/thehive-project.list
sudo apt update
```

### Install TheHive 4

```bash
sudo apt install thehive4 -y
```

---

## ⚙️ TheHive Configuration

Edit the configuration file `/etc/thehive/application.conf`. These are the only changes made:

```hocon
backend: cql
hostname: ["192.168.0.103"]
provider: localfs
localfs.location: /opt/thp/thehive/files
```

These settings point TheHive to use Cassandra and store file attachments locally.

---

## 🚀 Start TheHive Service

Start the service and confirm it is active:

```bash
sudo service thehive start
systemctl status thehive
```

---

## ✅ Verification

### 1. Confirm Cassandra Node is UP

```bash
nodetool status
```

Expected output shows Cassandra node `192.168.0.103` in state `UN` (Up/Normal):

```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens  Owns (effective)  Host ID                               Rack
UN  192.168.0.103  160.1 KiB  16      100.0%            aaf2d3cd-d743-48ae-be2c-bba9d76761ce  rack1
```

### 2. Check Cassandra Service

```bash
systemctl status cassandra
```

Status must be `active (running)`.

### 3. Check TheHive Service

```bash
systemctl status thehive
```

Status should show the Java service running and loading the correct config file.

### 4. Web Interface

Go to:

```
http://<your-server-ip>:9000
```

You should see the TheHive login page:

![TheHive Login Page](thehive.png)

This confirms that the web service is reachable and fully operational.
