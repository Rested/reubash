#!/usr/bin/env bash

function dockertags () {
  if [ $# -lt 1 ]
  then
    cat <<HELP
    dockertags  --  list all tags for a Docker image on a remote registry.

    EXAMPLE: 
        - list all tags for ubuntu:
        dockertags ubuntu

        - list all php tags containing apache:
        dockertags php apache
HELP
  fi

  image="$1"
  tags=$(wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}')

  if [ -n "$2" ]
  then
    tags=$(echo "${tags}" | grep "$2")
  fi

  echo "${tags}"
} 

function aa () {
  echo "alias $1='${@:2}'" >> ~/.aliases
}

function grepal () {
  echo $(cat ~/.aliases | grep $1)
}

function wslip () {
  echo $(ifconfig | grep -A 1 eth0 | grep inet | grep -Eo [0-9\.]+ | head -n 1)
}

function lopen () {
  openwsl http://$(wslip):$1
}

function kdfns () {
  kubectl config set-context --current --namespace=$1
}