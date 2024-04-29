
#  Ansible
## Présentation
Ansible est un outil développé par RedHat depuis 2012.
C'est in outils dévelopé en Python, il s'installe sur les postes comme un module Python  avec `pip`
Les actions sont lancées via ssh sur les serveurs, des scripts temporaires sont copiés sur les serveurs puis exécutés.
Pour cette raison il est dans la plus part des cas nécessaire d'avoir également python installé sur ces serveurs, ce qui
est le cas de la majorité des serveurs fonctionnant avec Linux

## Installation

```sh
 python3 -m pip install --user ansible [ --break-system-packages]
```

## Inventaire : Configuration des serveurs

L'inventaire Ansible décrit les serveurs à adresser, il permet de grouper ceux-ci par role.

Il permet également de mettre en place des varibles qui seront utilisées par les modules ansible

* exemple
```yaml
web-preprod:
  hosts:
    web-pp-1:
      ansible_host: 192.168.122.164
      ansible_user: debian
      var1: value
web-prod:
  hosts:
    web1.exemple.com:
    web2.exemple.com:
  vars:
    var1: value-prod
web:
  children:
    web-preprod
    web-prod
```

* Tester l'inventaire :

```
ansible-inventory -i <inventory.yaml> --help
```

 * Test la connexion aux serveurs de l'inventaire
```
 ansible -i inventory.yaml  -m ping all
```

 ## Présentation d'Ansible-playbook

Un playbook ansible est un fichier contenant une liste d'actions à effectuer sur les serveurs.
Comme le `ping`, ces actions sont lancées par des modules python. A l'installation d'Ansible, une bibliothèque
de modules dits `buildin` sont installés.


```yaml
---
- hosts: all
  tasks:
  - name: ping tous les serveurs
    ansible.builtin.ping:
```

```
 ansible-playbook -i inventory.yaml  ping_all.yaml
 ansible-playbook -i inventory.yaml  ping_all.yaml --limit web-pp-1
```


 ## Rédaction d'un playbook pour mettre à jour des serveurs Linux Ubuntu

Pour effectuer cette action, il faudra :
  * que l'utilisateur Ansible devienne "root" sur les serveurs distants.
  * Utiliser le module `apt` d'Ansible
  * Utiliser un `register` qui permettra de redémarrer les serveurs si le kernel a été mis à jour

## Utilisation d'un playbook existant

https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-lamp-on-ubuntu-18-04



## Installation de Grafana et Prometheus avec Ansible

Le playbook fera sur un serveur :
* Installation des prérequis et Prometheus
* Installation de Grafana
   * Installation de la source `registery apt` de Grafana
   * Update de la base des paquets
   * Installation du paquet
* s'assurer que les services grafana et prometheus sont démarrés et activés aux redémarrages du serveur
* Configurer nginx pour servir grafana:
  * certificat auto-signé
  * Fichier de configuration poussé sur le serveur
* Configurer Prometheus pour qu'il requète plusieurs serveurs
* Installer sur les serveurs "client" le "prometheus-node-exporter" et activer le service
