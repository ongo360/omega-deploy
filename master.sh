#!/usr/bin/env bash


DEFAULT_DEV=${DEFAULT_DEV:-"eth0"}
DEFAULT_IP=`ifconfig ${DEFAULT_DEV} | grep inet | awk '{{print $2}}'`
DISCOVERY_URL=${DISCOVERY_URL:-"zk://${DEFAULT_IP}:2181/default"}





docker run -ti --rm -v $(pwd):$(pwd) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w $(pwd)/swarm \
    -e DOCKER_HOST=unix:///var/run/docker.sock \
    -e DISCOVERY_URL=${DISCOVERY_URL} \
    -e DOCKER_IP=${DEFAULT_IP} \
    docker/compose:1.9.0 \
    up -d



echo "alias swarm='docker -H localhost:2375 '" >> ~/.bashrc

source ~/.bashrc


docker run -ti --rm -v $(pwd):$(pwd) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w $(pwd)/plugins/swarm/network \
    -e DOCKER_HOST=unix:///var/run/docker.sock \
    -e ZK_URL=${DISCOVERY_URL} \
    -e DEFAULT_DEV=${DEFAULT_DEV} \
    docker/compose:1.9.0 \
    -f vxlan-compose.yml \
    -p network \
    up -d


echo "omega api starting at ${DEFAULT_IP}:8080 ......"
