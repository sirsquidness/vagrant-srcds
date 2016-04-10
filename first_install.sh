#!/usr/bin/env bash

set -e
apt-get update
apt-get install -y btrfs-tools git

mkdir /data

# if AWS, we mount a separate EBS volume to store the game server
if [ -e /dev/xvde ];
then
    mkfs.btrfs /dev/xvde
    mount /dev/xvde /data
fi


cd /data
mkdir docker

ln -s /data/docker/ /var/lib/

curl -sSL https://get.docker.com | sh
service docker stop || true

ls -la /var/lib | grep docker
ls /var/lib/docker/

# https://github.com/docker/docker/issues/20312#issuecomment-187930154
rm -f /var/lib/docker/network/files/local-kv.db
service docker start



git clone https://github.com/sirsquidness/gameservers-docker.git

cd gameservers-docker/steamcmd

docker build -t steamcmd . || docker daemon -D

cd ../csgo
docker build -t csgo .

cd ../csgo-ebot
docker build -t csgo-ebot .

