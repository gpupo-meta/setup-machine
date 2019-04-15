# Setup Machine scripts

## Setup new __AWS EC2 (v2)__ instance to run Docker

    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine && cd /tmp/setup-machine && bash aws-ec2-setup.sh;

## Setup new __Debian__ Developer Machine

    su -;
    apt-get -y install sudo git;
    usermod -aG sudo $USER;

Logout, login and run:

    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine && cd /tmp/setup-machine && bash ./debian-development-setup.sh;

## Setup new __Ubuntu__ Developer Machine

Tested with **Ubuntu 19.04 Disco Dingo**

    sudo apt-get -y install git;

    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine && cd /tmp/setup-machine && bash ./ubuntu-development-setup.sh;
