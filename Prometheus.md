# Prometheus

## Qu'est-ce que Prometheus'
Outil de monitoring, qui permet d'agréger les métriques de différents conteneurs, serveurs, applicatifs

* Principalement utilisé sur des environnements de conteneurs hautement dynamiques
   * Kubernetes, Docker Swarm, etc

* Fonctionne aussi sur des serveurs virtuels ou physiques

## Pourquoi utiliser Prometheus

Sur des infrastructures complexes, il est difficile de déterminer rapidement ce qui ne va pas : hardware, réseau, application...

Prometheus monitore tous les services et peut générer des alertes avec un outil tiers : Alertemanager


## Comment Prometheus fonctionne

* Serveur Prometheus

   * "Data Retrieval Worker" : responsable de récupérer ou recevoir les métriques (GET or PULL)
   * "Time Series Database" : reçoit les métriques et les stocke
   * "HTTP Server", expose les métriques.

* Clients (Serveurs, service à monitorer)
  * Expose les métriques : "Exporter" formate les logs d'une '


## Que peut monitorer Prometheus

* Serveurs : Linux, Windows
* Application : Nginx, Base des données, Elasticsearch, etc.
* CPU, RAM, espace disque
* Réseau : bande passante, nombre de requêtes, etc.

## Métriques

Au format texte, ils sont lisibles.

* Conteur : combien de fois X est arrivé
* Gauge : valeur actuelle de X
* Histogramme
