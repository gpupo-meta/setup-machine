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
alias docker-stop-all='docker stop $(docker ps -a -q)'
alias docker-remove-all='docker rmi $(docker images -a -q)'
alias docker-container-stats='docker ps -q | xargs  docker stats --no-stream';

