#!/usr/bin/env bash
STORAGE=${STORAGE:-"overlay"}
REGISTRY_MIRROR=${REGISTRY_MIRROR:-"https://rmw18jx4.mirror.aliyuncs.com"}

modprobe overlay
yum install -y curl wget tcpdump jq bridge-utils bind-utils
rpm -U ./binary/omega-docker-1.11.1-*.x86_64.rpm
echo "BOOTSTRAP_OPTS='--registry-mirror=${REGISTRY_MIRROR} -s ${STORAGE}' " > /etc/default/bootstrap
cp ./bootstrap/bootstrap.service /etc/systemd/system/bootstrap.service
cp ./bootstrap/bootstrap.socket  /etc/systemd/system/bootstrap.socket
echo "alias bootstrap='docker -H unix:///var/run/bootstrap.sock '" >> ~/.bashrc
source ~/.bashrc

systemctl daemon-reload
systemctl restart bootstrap
SECONDS=0
while [[ $(docker -H unix:///var/run/bootstrap.sock ps 2>&1 1>/dev/null; echo $?) != 0 ]]; do
    ((SECONDS++))
  if [[ ${SECONDS} == 11 ]]; then
      echo "bootstrap failed to start. Exiting..."
      exit 1
  fi
  sleep 1
done

docker -H unix:///var/run/bootstrap.sock rm -f zk 

docker -H unix:///var/run/bootstrap.sock run -d \
    --name zk \
    --restart=always \
    --net=host  \
    -v /var/lib/zookeeper/data:/var/lib/zookeeper/data \
    -v /var/lib/zookeeper/datalog:/var/lib/zookeeper/datalog \
    zookeeper:3.4.9


LOCAL_IP=$(ifconfig eth0 | grep inet | awk '{{print $2}}')

MASTER_IP=${MASTER_IP:-$LOCAL_IP}


if [[ ${LOCAL_IP} == ${MASTER_IP} ]]; then
     cd plugins/swarm/consul && bash -x start.sh server dnsmasq
else
     cd plugins/swarm/consul && bash -x start.sh agent dnsmasq
fi

cd ../../..