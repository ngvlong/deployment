#!/bin/bash

function update(){
    apt-get update -y
    apt-get upgrade -y
}

function setting_apt_proxy(){
    if [ -n $PROXY ]; then
        echo 'Acquire::http::Proxy "'$PROXY'";' > /etc/apt/apt.conf
        echo 'Acquire::https::Proxy "'$PROXY'";' >> /etc/apt/apt.conf
        echo 'Acquire::ftp::Proxy "'$PROXY'";' >> /etc/apt/apt.conf
    fi
}

function setting_apt_source(){
    echo 'deb http://security.debian.org/ jessie/updates main contrib' > /etc/apt/sources.list
    echo 'deb-src http://security.debian.org/ jessie/updates main contrib' >> /etc/apt/sources.list
    echo 'deb http://ftp.debian.org/debian/ jessie-updates main contrib' >> /etc/apt/sources.list
    echo 'deb-src http://ftp.debian.org/debian/ jessie-updates main contrib' >> /etc/apt/sources.list
    echo 'deb http://ftp.de.debian.org/debian jessie main' >> /etc/apt/sources.list
    
}

function install_docker() {
    apt-get remove docker docker-engine docker.io
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -x $PROXY -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt-get update -y
    apt-get install docker-ce
}

function install_docker_compose() {
    curl -x $PROXY -L "https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

function setting_docker_proxy() {
    if [ -n $PROXY ]; then
        mkdir /etc/systemd/system/docker.service.d
        echo "[Service]" > /etc/systemd/system/docker.service.d/http-proxy.conf
        echo 'Environment="HTTP_PROXY="'$PROXY'" "HTTPS_PROXY='$PROXY'" "NO_PROXY=localhost,127.0.0.0/8,192.168.0.0/16"'

        systemctl daemon-reload
        systemctl restart docker
    fi
}

function usage(){
    echo "Install"
}

echo "Start"

PROXY=''
cmd=''
arg=''
while [ "$1" != "" ]; do
    case $1 in
        --proxy )   shift
                    PROXY=$1
                    ;;
        install)    shift
                    cmd=install
                    arg=$1
                    ;;
        --help) usage
                exit
                ;;
        * )     ;;
    esac
    shift
done

setting_apt_proxy
setting_apt_source
update

install_docker
install_docker_compose
setting_docker_proxy

echo "Done"