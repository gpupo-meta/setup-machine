#!/bin/bash

### WARNING: This is an incomplete script !!!

brew install docker docker-compose docker-machine
brew cask install virtualbox;

### NEED PERMISSIONo

docker-machine create --driver virtualbox default;

docker-machine env default >> ~/.profile


docker-machine start default

# Httpd Gateway
cd ~;
git clone https://github.com/gpupo/httpd-gateway.git;
pushd httpd-gateway;
make setup;


# SSH Key
ssh-keygen -t rsa -b 4096 -C ${ec2InstanceId}
cat ~/.ssh/id_rsa.pub

#Clean
rm -Rf /tmp/crontab /tmp/gist;

## Set yout DVCS
git config --global user.name "Gilmar Pupo"
git config --global user.email "contact@gpupo.com"
