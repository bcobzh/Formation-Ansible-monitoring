#!/bin/bash
cd $(dirname $0)
(for i in $(seq 1 30); do curl -f http://localhost:5665 && break; sleep 1; done && sleep 3 && open http://localhost:5665) &
docker run --name k6-ag --rm -i -v $(pwd):/test -w /test -p 5665:5665 ghcr.io/szkiba/xk6-dashboard:latest run --out=dashboard ./test1.js
