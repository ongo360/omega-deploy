#!/usr/bin/env bash

HOST_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

docker run -ti --rm \
   -v $(pwd):$(pwd) \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -w $(pwd) \
   -e DOCKER_HOST=unix:///var/run/docker.sock  \
   -e ZK_URL=${ZK_URL} \
   -e HOST_IP=${HOST_IP} \
   docker/compose:1.9.0   \
   up -d $*
