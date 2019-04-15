#!/bin/bash
#
# Setup new Ubuntu Disco Dingo to run Docker and Development Tools
##

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common;

#Add Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"

sudo apt-get update;
sudo apt-get install docker-ce docker-ce-cli containerd.io;
#source ./debian/common-setup.sh;
