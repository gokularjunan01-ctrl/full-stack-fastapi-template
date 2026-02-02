#!/bin/bash
set -e

apt update -y
apt install -y python3 docker.io docker-compose git awscli

systemctl start docker
systemctl enable docker

cd /home/ubuntu

git clone https://github.com/gokularjunan01-ctrl/full-stack-fastapi-template.git app
cd app

docker compose up -d
