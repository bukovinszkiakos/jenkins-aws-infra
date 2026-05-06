#!/bin/bash

apt update -y
apt install docker.io -y

systemctl start docker
systemctl enable docker

mkdir /jenkins

cat <<EOF > /jenkins/JenkinsDockerfile
FROM jenkins/jenkins:lts

USER root

RUN apt update && \
    apt install -y docker.io awscli

USER jenkins
EOF

cd /jenkins

docker build -t custom-jenkins -f JenkinsDockerfile .

docker run -d \
  --restart unless-stopped \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  custom-jenkins