#!/bin/bash

apt update -y

apt install -y docker.io git curl

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
