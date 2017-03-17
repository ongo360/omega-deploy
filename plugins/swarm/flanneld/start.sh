#!/usr/bin/env bash


HOST_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

ETCD_URL=${ETCD_URL:-"http://"${HOST_IP}:2379}
docker run -ti --rm -v $(pwd):$(pwd) \
	-v /var/run/docker.sock:/var/run/docker.sock \
        -e DOCKER_HOST=unix:///var/run/docker.sock  \
        -e ETCD_URL=${ETCD_URL} \
        -e HOST_IP=${HOST_IP} \
        -w $(pwd)  docker/compose:1.9.0 \
        up -d
