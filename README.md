# Formation`

## Prérequis
* Un accès ssh depuis les postes de travail vers les différents serveurs
* Python 3 installé sur les postes de travail (Ansible)
* Pour Une VM Ubuntu, pour le labo Grafana, sur DigitalOcean pouvant accéder aux serveurs de préproduction

## `Ansible`

### Présentation

### Installation

### Configuration de l'inventaire

* Fichier host.ini

* `ansible ping`

### `Playbook`

* Fichier de variables
* Mots clés :
  * `host`
  * `tasks`
    * Modules : Actions prédéfinies dans `Ansible`
  * `become_user`
  * `register`
  * `when`

### Labo: Mise en place d'un playbook pour mettre à jour les serveurs

## `Grafana/Prometheus`


### Présentation

* `Prometheus`
  Prometeus est un logiciel de collecte, stockage de métriques.
  Il permet d'afficher des graphes à partir de ces métriques, mais ces graphes sont très basiques
 * `Grafana`

### Installation sur `Ubuntu/Debian`

* Installation
  playbook Ansible

### Configuration

* `Prometheus`
  * Mise en place des `exporters` (manuellement ou via Ansible)
    * Métriques système Linux: CPU, RAM, disques, réseau
    * Métriques php-fpm
    * Métriques ElasticSeach
  * Configuration des jobs Prometheus (manuellement ou via Ansible)
* `Grafana`
  * Installation des Dasboard qui exploitent les métriques Prometheus
* Grafana Loki

## Test de montée en Charge

* Présentation de K6
* Installation de K6
* Préparation d'un scénario
* Lancement d'un test et observation des effets sur Grafana
