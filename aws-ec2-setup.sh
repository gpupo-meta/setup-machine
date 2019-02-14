#!/bin/bash
#
# Setup new AWS EC2 (v2) instance to run Docker
##

cat bin/.bash_aliases > ~/.bash_aliases;
cat config/.env > ~/.env;
cd ~ && source .env
ec2InstanceId=$(ec2-metadata --instance-id | cut -d " " -f 2);

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


# SSH Key
ssh-keygen -t rsa -b 4096 -C ${ec2InstanceId}
cat ~/.ssh/id_rsa.pub

#Clean
rm -Rf /tmp/crontab /tmp/gist;
