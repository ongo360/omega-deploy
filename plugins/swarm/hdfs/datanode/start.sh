#!/usr/bin/env bash
LOCAL_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

docker run -ti --rm -v $(pwd):$(pwd) \
	-v /var/run/docker.sock:/var/run/docker.sock \
        -e DOCKER_HOST=unix:///var/run/docker.sock  \
        -e NETWORK=${NETWORK} \
        -w $(pwd) \
        docker/compose:1.9.0 \
        -p myhadoop-${LOCAL_IP} \
        up -d
