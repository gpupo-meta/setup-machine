# setup-machine

## Setup new AWS EC2 (v2) instance to run Docker

  git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine && cd /tmp/setup-machine && bash aws-ec2-setup.sh;


## Setup new Debian Developer Machine

  su -;

  apt-get -y install sudo git;

  usermod -aG sudo $USER;


Logout ... login ... and run:


  git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine && cd /tmp/setup-machine && bash debian-development-setup.sh;
