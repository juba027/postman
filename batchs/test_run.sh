#!/usr/bin/env bash
set -e

mkdir -p test-results

docker run --rm \
  -v "$PWD":/etc/newman \
  -w /etc/newman \
  postman/newman:alpine \
  run get_home.postman_collection.json \
    --reporters cli,junit \
    --reporter-junit-export test-results/get_home.xml

docker run --rm \
  -v "$PWD":/etc/newman \
  -w /etc/newman \
  postman/newman:alpine \
  run get_welcome.postman_collection.json \
    --reporters cli,junit \
    --reporter-junit-export test-results/get_welcome.xml
