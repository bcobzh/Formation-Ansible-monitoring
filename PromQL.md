
# PromQl

PromQL(Prometheus Query Language) permet de filtrer les métriques et est utilisé pour créer des
Dasboard Grafana et remonter des alertes

## type de métriques

* String
* Scalar
* Range Vector
  une liste de valeurs sur une plage de temps

* Instant Vector
  une valeur pour un temps déterminé

## Data type

* Counter: augmente en permanence
  fonction : rate
  * `rate(counter[period])` retourne une valeur par seconde sur la `period`
  * `rate(range_vertor)` -> 'Instance Vector'
  Si l'exporter redémarre ,  le compteur repart de 0
* Gauge: Métriques qui peuvent monter ou descendre
  * CPU
  * RAM
  * Temps de réponse
  Fontions:
    avg_over_time(http_response_time[5m])
* Histogram: sert à agréger les données
   utilisé pour stoker des moyenne, pourcentil

   `rate(metric_duration_sum) / rate(request_duration_count)`
   * Pour les poucentil: histogram_quantile
* Summary
   S'il n'est pas nécessaire d'avoir des valeurs précises
    * Temps de réponse
    * Taille des réponses
    * volumétrie échangée
## Filters
### Label
Les enregistrements dans Prometheus contiennent des `labels` ,les filtres se font sur ceux-ci

```
prometheus_http_requests_total{code="200",handler="/api/v1/label/:name/values",instance="localhost:9090",job="prometheus"}

prometheus_http_requests_total{code="200"}
prometheus_http_requests_total{code=~"2.+"} #

```

### Range
Permet de sélectionner une période de temps depuis maintenant
[(chiffre)(unité de temps]
où unité de temps est [ms, s, m, h, d, w, y]

### Offset

Donne la valeur de la métrique à la valeur de l'offset avant le temps présent

```
prometheus_http_requests_total offset 2h
```
* Spécifier une date précise : timestamp

``` bash
prometheus_http_requests_total @1712149671.372
```

## Operators

* Aggregation: uniquement sur "instant Vector" et retourne un "instant Vector"
    * sum
    * min
    * max
    * stddev
    * avg
    * ...
* Binary:
   * arithmétique: +, -, *, / , %
   * comparaison:  == , !=, <= , >= , > ,<
   * booléen: and, or, unless

* Fonctions
  * rate(<range vector>) ==> <instant vector>


## Tutoriel

* compteurs
   ```
  sum by(handler) (rate(prometheus_http_requests_total{handler=~"/api/.*"}[1m]))
  count(node_systemd_unit_state{state="active"})  by(instance)
  rate(node_disk_io_time_seconds_total[5m])
   ```
