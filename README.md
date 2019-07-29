# Setup Machine scripts

Scripts that configure a super cool environment

## Development environments

Install and configure:

* docker & docker-compose
* php 7 & composer
* Atom
* Microsoft Vscode
* Unix like tools
* git + setup new **ssk key**
* [httpd-gateway](https://opensource.gpupo.com/httpd-gateway/)
* [custom bash aliases](https://github.com/gpupo-meta/setup-machine/blob/master/bin/.bash_aliases)

### Setup new __Debian__ Developer Machine

Tested with **Debian 9 Stretch**

    su -;
    apt-get -y install sudo git;
    usermod -aG sudo $USER;

``Logout``, ``login`` and run:

    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine;
    cd /tmp/setup-machine;
    bash ./debian-development-setup.sh;

### Setup new __Ubuntu__ Developer Machine

Tested with **Ubuntu 19 Disco Dingo**

    sudo apt-get -y install git;

    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine;
    cd /tmp/setup-machine;
    bash ./ubuntu-development-setup.sh;


## Production environments

Install and configure:

* aws-scripts-mon
* docker & docker-compose
* setup new **ssk key**
* [httpd-gateway](https://opensource.gpupo.com/httpd-gateway/)
* [custom bash aliases](https://github.com/gpupo-meta/setup-machine/blob/master/bin/.bash_aliases)

### Setup new __AWS EC2 (v2)__ instance to run Docker

    sudo yum install -y git;
    git clone https://github.com/gpupo-meta/setup-machine.git /tmp/setup-machine;
    cd /tmp/setup-machine;
    bash aws-ec2-setup.sh;
