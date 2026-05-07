#!/bin/bash

apt update -y
apt install docker.io -y

systemctl start docker
systemctl enable docker

sleep 20

if ! blkid /dev/nvme1n1; then
  mkfs -t ext4 /dev/nvme1n1
fi

mkdir -p /jenkins-data

mount /dev/nvme1n1 /jenkins-data

mkdir /jenkins

cat <<EOF > /jenkins/JenkinsDockerfile
FROM jenkins/jenkins:lts

USER root

RUN apt update && \
    apt install -y docker.io awscli

EOF

cd /jenkins

docker build -t custom-jenkins -f JenkinsDockerfile .

docker run -d \
  --restart unless-stopped \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /jenkins-data:/var/jenkins_home \
  custom-jenkins