#!/usr/bin/env bash



if [[ -z ${DISCOVERY_URL} ]]; then
     echo "Please export DISCOVERY_URL in your env"
     exit 1
fi


STORAGE=${STORAGE:-"overlay"}
DEFAULT_DEV=${DEFAULT_DEV:-"eth1"}
DEFAULT_IP=`ifconfig ${DEFAULT_DEV} | grep inet | awk '{{print $2}}'`












docker run -ti --rm -v $(pwd):$(pwd) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w $(pwd)/plugins/network \
    -e DOCKER_HOST=unix:///var/run/docker.sock \
    -e ZK_URL=${DISCOVERY_URL} \
    -e DEFAULT_DEV=${DEFAULT_DEV} \
    docker/compose:1.9.0 \
    -f plugins/network/vxlan-compose.yml \
    -p network \
    up -d


docker run -ti --rm -v $(pwd):$(pwd) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w $(pwd)/swarm \
    -e DOCKER_HOST=unix:///var/run/docker.sock \
    -e DISCOVERY_URL=${DISCOVERY_URL} \
    -e DOCKER_IP=${DEFAULT_IP} \
    docker/compose:1.9.0 \
    up -d agent


