#!/usr/bin/env bash




STORAGE=${STORAGE:-"overlay"}
DEFAULT_DEV=${DEFAULT_DEV:-"eth1"}
REGISTRY_MIRROR=${REGISTRY_MIRROR:-"https://rmw18jx4.mirror.aliyuncs.com"}
MTU=${MTU:-1450}
DEFAULT_IP=`ifconfig ${DEFAULT_DEV} | grep inet | awk '{{print $2}}'`

modprobe overlay
modprobe openvswitch

rpm -U  ./binary/omega-docker-1.11.1-*.x86_64.rpm
DISCOVERY_URL=${DISCOVERY_URL:-"zk://localhost:2181/default"}

echo "DOCKER_OPTS='--registry-mirror=https://rmw18jx4.mirror.aliyuncs.com  -s ${STORAGE} --mtu=${MTU} --cluster-store=${DISCOVERY_URL} --cluster-advertise=${DEFAULT_DEV}:2376'" > /etc/default/docker
systemctl daemon-reload
systemctl restart docker
SECONDS=0
while [[ $(docker ps 2>&1 1>/dev/null; echo $?) != 0 ]]; do
    ((SECONDS++))
  if [[ ${SECONDS} == 10 ]]; then
      echo "docker failed to start. Exiting..."
      exit 1
  fi
  sleep 1
done

docker login -u sadan@aliyun.com -p hell05a registry.cn-hangzhou.aliyuncs.com
