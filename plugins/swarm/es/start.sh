#!/usr/bin/env bash
docker run -ti --rm \
   -v $(pwd):$(pwd)  \
   -w $(pwd) \
   -e DOCKER_HOST=${DOCKER_HOST}  \
   -e NETWORK=${NETWORK} \
   docker/compose:1.9.0   \
   up -d
