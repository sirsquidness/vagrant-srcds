#!/usr/bin/env bash

# aws image uses admin, vultr image uses sudo
grep admin /etc/group && group="admin" || group="sudo"

groupadd vagrant
useradd vagrant -g vagrant -G $group --create-home --password '$6$0hUChQbgDXT5$fy6tSeiSWIl2Tdy5NVvOXZaxAn2JaiUD9tBCkybs7MDXlyfo1T58lvb1BedWqNxTU1ZISYq0LtktDT6P95GZl/'
#echo "vagrant" | passwd --stdin vagrant
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/99-vagrant

mkdir /home/vagrant/.ssh

# Use my own private key
cat  /tmp/key.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

