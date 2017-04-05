#!/usr/bin/env bash

LOCAL_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

MASTER_IP=${MASTER_IP:-$LOCAL_IP}

docker run -ti --rm \
   -v $(pwd):$(pwd) \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -w $(pwd) \
   -e DOCKER_HOST=unix:///var/run/docker.sock  \
   -e MASTER_IP=${MASTER_IP} \
   -e LOCAL_IP=${LOCAL_IP} \
   docker/compose:1.9.0   \
   up -d $*
