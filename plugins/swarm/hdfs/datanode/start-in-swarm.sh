#!/usr/bin/env bash
docker run -ti --rm -v $(pwd):$(pwd) \
        -e DOCKER_HOST=${DOCKER_HOST}  \
        -e NETWORK=${NETWORK} \
        -w $(pwd) \
        docker/compose:1.9.0 \
        up -d
