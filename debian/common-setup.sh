
#docker-compose
sudo rm /usr/bin/docker-compose > /dev/null
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;
sudo ln -snf /usr/local/bin/docker-compose /usr/bin/docker-compose ;
docker-compose version;

# Httpd Gateway
if [ ! -d ~/httpd-gateway ]; then
  pushd ~ && git clone https://github.com/gpupo/httpd-gateway.git && pushd httpd-gateway && make setup;
  mkdir ~/workspace;
  popd;
fi

# SSH Key
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "${USER}@${HOSTNAME}";
  cat ~/.ssh/id_rsa.pub;
fi

#ATOM
command -v apm >/dev/null 2>&1 || {
  LatestUrlRedirection="$(curl https://github.com/atom/atom/releases/latest)"
  LatestVersionUrl="$(grep -o -E 'href="([^"#]+)"' <<< $LatestUrlRedirection)"
  PrefixUrlForDownload="$(cut -d'"' -f2 <<< $LatestVersionUrl)"
  PrefixUrlForDownload="$(awk '{gsub(/tag/,"download")}1' <<< $PrefixUrlForDownload)"
  SufixUrlForDownload="/atom-amd64.deb"
  UrlForDownload="$PrefixUrlForDownload$SufixUrlForDownload"
  wget --progress=bar $UrlForDownload -O /tmp/atom-amd64.deb;
  sudo dpkg -i /tmp/atom-amd64.deb && rm /tmp/atom-amd64.deb;
}

#Atom config and packages
if [ ! -d ~/.atom/packages/language-dotenv ]; then
  apm install --packages-file /tmp/setup-machine/debian/apm-packages
  cat /tmp/setup-machine/debian/atom-config.cson > ~/.atom/config.cson
fi

#Chrome
command -v chrome-gnome-shell >/dev/null 2>&1 || {
  wget  --progress=bar https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
  sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb && rm /tmp/google-chrome-stable_current_amd64.deb;
}

#Locate
command -v locate >/dev/null 2>&1 || {
  sudo apt-get install locate;
  sudo updatedb;
}

#PHP and xtras
command -v php >/dev/null 2>&1 || {
  sudo apt --fix-broken install;
  sudo apt-get install -y apt-utils iputils-ping procps\
    unzip zlib1g-dev libpng-dev libjpeg-dev gettext-base libxml2-dev libzip-dev \
    libmcrypt-dev mysql-client libicu-dev \
    libcurl4-openssl-dev pkg-config libssl-dev telnet vim netcat \
    kcachegrind \
    php-intl php-gd php-apcu php-zip php-xml libmariadbclient-dev;
}

#Composer
command -v composer >/dev/null 2>&1 || {
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"
  sudo mkdir -p /usr/local/bin/;
  sudo mv -v composer.phar /usr/local/bin/composer; sudo chmod +x /usr/local/bin/composer;
}

#vscode
command -v code >/dev/null 2>&1 || {
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt-get update
  sudo apt-get install code
}

sudo apt --fix-broken install;
