#!/usr/bin/env bash
docker run -ti --rm \
   -v $(pwd):$(pwd)  \
   -v /var/run/docker.sock:/var/run/docker.sock   \
   -w $(pwd) \
   -e DOCKER_HOST=unix:///var/run/docker.sock  \
   -e NETWORK=${NETWORK} \
   -e SWARM_URL=${SWARM_URL} \
   docker/compose:1.9.0   \
   up
