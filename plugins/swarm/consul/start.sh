#!/usr/bin/env bash

LOCAL_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

HOST_IP=${HOST_IP:-$LOCAL_IP}

docker run -ti --rm \
   -v $(pwd):$(pwd) \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -w $(pwd) \
   -e DOCKER_HOST=unix:///var/run/docker.sock  \
   -e HOST_IP=${HOST_IP} \
   -e LOCAL_IP=${LOCAL_IP} \
   -e ZK_URL=${ZK_URL} \
   docker/compose:1.9.0   \
   up -d $*
