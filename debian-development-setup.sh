#!/bin/bash
#
# Setup new Debian to run Docker and Development Tools
##

cat bin/.bash_aliases > ~/.bash_aliases;
cat config/.env > ~/.env;
cd ~ && source .env
mkdir -p ~/workspace/

sudo apt-get -y install  python apt-utils iputils-ping telnet openssh-server \
    apt-transport-https \
    ca-certificates \
    curl wget\
    gnupg2 git-all git-cola \
    software-properties-common \
    inkscape clang-format-3.8 gimp firefox-esr libappindicator3-1 \
    libindicator3-7 libdbusmenu-glib4 libdbusmenu-gtk3-4;

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo groupadd docker
sudo usermod -aG docker $USER

#docker-compose
sudo rm /usr/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;
sudo ln -snf /usr/local/bin/docker-compose /usr/bin/docker-compose ;
docker-compose version;


# Httpd Gateway
cd ~ && git clone https://github.com/gpupo/httpd-gateway.git && pushd httpd-gateway && make setup;

# SSH Key
ssh-keygen -t rsa -b 4096 -C "${USER}@debian"
cat ~/.ssh/id_rsa.pub


#ATOM
LatestUrlRedirection="$(curl https://github.com/atom/atom/releases/latest)"
LatestVersionUrl="$(grep -o -E 'href="([^"#]+)"' <<< $LatestUrlRedirection)"
PrefixUrlForDownload="$(cut -d'"' -f2 <<< $LatestVersionUrl)"
PrefixUrlForDownload="$(awk '{gsub(/tag/,"download")}1' <<< $PrefixUrlForDownload)"
SufixUrlForDownload="/atom-amd64.deb"
UrlForDownload="$PrefixUrlForDownload$SufixUrlForDownload"
wget --progress=bar $UrlForDownload -O /tmp/atom-amd64.deb;
sudo dpkg -i /tmp/atom-amd64.deb && rm /tmp/atom-amd64.deb;


#Chrome
wget  --progress=bar https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb && rm /tmp/google-chrome-stable_current_amd64.deb;
