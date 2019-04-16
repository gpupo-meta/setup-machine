#!/bin/bash
#
# Setup new Debian to run Docker and Development Tools
##

command -v make >/dev/null 2>&1 || {
  cat bin/.bash_aliases > ~/.bash_aliases;
  sudo cp -f debian/sources.list /etc/apt/sources.list;
  cat config/.env > ~/.env;
  pushd ~ && source .env;
  popd;
  mkdir -p ~/workspace/
  sudo apt-get -q update;

  sudo apt-get -y install libcurl3 gconf2 curl python apt-utils iputils-ping telnet openssh-server \
      apt-transport-https \
      ca-certificates \
      wget gnupg2 tree \
      git-all git-cola make \
      software-properties-common \
      inkscape clang-format-3.8 gimp firefox-esr libappindicator3-1 \
      libindicator3-7 libdbusmenu-glib4 libdbusmenu-gtk3-4;
}

#Docker
command -v docker >/dev/null 2>&1 || {
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh;
  sudo sh /tmp/get-docker.sh;
  sudo groupadd docker;
  sudo usermod -aG docker $USER;
}

source ./debian/common-setup.sh;
