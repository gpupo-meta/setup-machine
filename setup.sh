#!/bin/bash
sudo yum update;
sudo amazon-linux-extras install docker -y;
sudo usermod -a -G docker ec2-user;
sudo usermod -a -G root ec2-user;
sudo systemctl enable docker;

#docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;

#Date to America/Sao_Paulo
sudo timedatectl set-timezone America/Sao_Paulo

#Reboot
sudo shutdown -r now;
