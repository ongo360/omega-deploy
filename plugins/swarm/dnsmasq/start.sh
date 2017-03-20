#!/usr/bin/env bash
docker run -ti --rm \
   -v $(pwd):$(pwd)  \ 
   -w $(pwd) \  
   -e DOCKER_HOST=unix:///var/run/docker.sock  \
   -e CONSUL_URL=${CONSUL_URL} \
   docker/compose:1.9.0   \
   up $@
