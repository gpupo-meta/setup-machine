#!/bin/bash

shopt -s expand_aliases

## System
alias pip='pip3'

## Git
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gc='git commit -am'

## Docker
alias dc='docker-compose'
alias dc-up='docker-compose up -d'
alias dc-down='docker-compose down'
alias docker-stop-all='docker stop $(docker ps -a -q)'
alias docker-remove-all='docker rmi $(docker images -a -q)'

alias docker-container-stats='docker ps -q | xargs  docker stats --no-stream';



## Docker services
alias php-fpm-service='docker run -v "$PWD":/var/www/app --rm gpupo/container-orchestration:symfony-dev-v1.6.0'
alias composer='php-fpm-service composer'
alias phpunit='php-fpm-service vendor/bin/phpunit'
alias php-cs-fixer='php-fpm-service /root/.composer/vendor/bin/php-cs-fixer'
alias phpcs='php-fpm-service /root/.composer/vendor/bin/phpcs'
alias phpcbf='php-fpm-service /root/.composer/vendor/bin/phpcbf'


#project ONLY
alias project-php-fpm-service='dc run php-fpm'
alias project-php='project-php-fpm-service php'
alias project-console='project-php bin/console'
alias project-make='project-php-fpm-service make'
alias project-bash='project-php-fpm-service bash'
alias project-simple-phpunit='project-php-fpm-service vendor/bin/simple-phpunit'
alias project-phpunit='project-php-fpm-service vendor/bin/phpunit'
alias project-composer='project-php-fpm-service composer'
