#!/usr/bin/env bash
set -e
docker run --rm -v "$PWD":/etc/newman -w /etc/newman postman/newman:alpine sh -lc '
  mkdir -p test-results &&
  newman run POSTMAN/get_home.postman_collection.json --reporters cli,junit --reporter-junit-export test-results/get_home.xml &&
  newman run POSTMAN/get_welcome.postman_collection.json --reporters cli,junit --reporter-junit-export test-results/get_welcome.xml
'
