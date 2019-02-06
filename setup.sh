#!/bin/bash
#
# Setup new AWS EC2 (v2) instance to run Docker
# v1.2
# @see https://gist.github.com/gpupo/388b03f247f030969135c0819e87a990
#
# Usage:
# git clone https://gist.github.com/388b03f247f030969135c0819e87a990.git /tmp/gist && cd /tmp/gist && bash setup.sh;
##

cat .bash_aliases > ~/.bash_aliases;
cat .env > ~/.env;
cd ~ && source .env

sudo yum update -y && sudo yum install -y git-core;
sudo amazon-linux-extras install docker -y;
sudo usermod -a -G docker ec2-user;
sudo usermod -a -G root ec2-user;
sudo systemctl enable docker;

#docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;
docker-compose version;

#Date to America/Sao_Paulo
sudo timedatectl set-timezone America/Sao_Paulo;
date;

# Workspace
mkdir -p ~/stage;

# Aws Monitoring
sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
unzip CloudWatchMonitoringScripts-1.2.2.zip && \
rm CloudWatchMonitoringScripts-1.2.2.zip && \
pushd aws-scripts-mon;

printf "AWSAccessKeyId=${AWSAccessKeyId}\nAWSSecretKey=${AWSSecretKey}" > awscreds.conf
printf "# v1.2\n*/15 * * * * /home/ec2-user/aws-scripts-mon/mon-put-instance-data.pl --disk-space-avail --disk-path=/ --from-cron\n" > /tmp/crontab
crontab /tmp/crontab
crontab -l;


# Httpd Gateway
popd;
git clone https://github.com/gpupo/httpd-gateway.git;
pushd httpd-gateway;
make setup;


rm -Rf /tmp/crontab /tmp/gist;

#Reboot
#sudo shutdown -r now;
