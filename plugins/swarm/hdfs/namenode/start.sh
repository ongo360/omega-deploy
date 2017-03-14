#!/usr/bin/env bash
docker run -ti --rm -v $(pwd):$(pwd) \
	-v /var/run/docker.sock:/var/run/docker.sock \
        -e DOCKER_HOST=unix:///var/run/docker.sock  \
        -e NETWORK=${NETWORK} \
        -w $(pwd)  docker/compose:1.9.0 \
        -p hdfs \
        up -d
