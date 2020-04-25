#!/bin/bash
# Author: "MageEdu <mage@magedu.com>"
# Version: "V0.1"
#
if [ $UID -ne 0 ]; then
    echo "Must run as root."
    exit 1
fi

apt-get update && apt-get -y install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
apt update && apt install -y docker-ce 

[-d /etc/docker ] || mkdir /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "registry-mirrors":["https://4mii0w1b.mirror.aliyuncs.com", "https://docker.mirrors.ustc.edu.cn", "https://registry.docker-cn.com"]
}
EOF

systemctl daemon-reload && systemctl restart docker.service && systemctl enable docker.service


apt-get update && apt-get install -y apt-transport-https

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 

cat<<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

apt-get update && apt-get install -y kubelet kubeadm kubectl
