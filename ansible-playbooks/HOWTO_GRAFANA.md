# Sur Debian / Ubuntu
## Installation de la base de données
```
sudo apt update
```

## Installation Grafana


```
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update
# Installs the latest OSS release:
sudo apt-get install grafana nginx
```

### Configuration de la base de données pour Grafana

fichier /etc/grafana/grafana.ini

```
[database]
# You can configure the database connection by specifying type, host, name, user and password
# as separate properties or as on string using the url properties.

# Either "mysql", "postgres" or "sqlite3", it's your choice
type = mysql
host = 127.0.0.1:3306
;name = grafana
user = grafana
# If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
password = password
```

### Démarrage de grafana

```
sudo systemctl start grafana-server.service
```

## Exposer grafana via nginx

### Certificat, ici autosigné

```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/grafana-selfsigned.key -out /etc/ssl/certs/grafana-selfsigned.crt
```

### Configuration Nginx


fichier : /etc/nginx/sites-enabled/grafana
```
map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}

# this is upstream grafana. You can use dns name
upstream grafana {
  server locahost:3000;
}

server {
  listen 443 ssl;
  ssl_certificate /etc/ssl/certs/grafana-selfsigned.crt;
  ssl_certificate_key /etc/ssl/private/grafana-selfsigned.key;

  location / {
    proxy_set_header Host $http_host;
    proxy_pass http://grafana;
  }

  # Proxy Grafana Live WebSocket connections.
  location /api/live/ {
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
    proxy_set_header Host $http_host;
    proxy_pass http://grafana;
  }
}
```


```
ln -s
systemctl start nginx
```

## Installation Prometheus


```
apt-get install prometheus prometheus-node-exporter
systemctl enable --now prometheus
systemctl enable --now  prometheus-node-exporter
```
