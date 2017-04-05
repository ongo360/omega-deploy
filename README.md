# omega-deploy


## 初始化节点

```
yum install -y git curl tcpdump && cd /opt && git clone https://github.com/ongo360/omega-deploy.git 
```

## 初始化server

```
cd /opt/omega-deploy &&  bash -x init-zk.sh && bash -x init-node.sh && bash -x master.sh
```

## 初始化worker
```
export DISCOVERY_URL=zk://xxxx:2181/default
cd /opt/omega-deploy &&  bash -x init-node.sh && bash -x worker.sh

```
