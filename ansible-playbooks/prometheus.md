# Prometheus

## PromQL

```
sum by (instance) (prometheus_http_requests_total)
sum by (instance) (node_cpu_seconds_total{mode="idle"})

sum by (job) (rate(prometheus_http_requests_total[10m]) )
```
