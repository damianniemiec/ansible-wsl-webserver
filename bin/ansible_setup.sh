#!/bin/bash
if [ -d /mnt/c/ ]; then
    if [ ! -f /etc/wsl.conf ]; then    
        echo "[automount]
        enabled = true
        root = /mnt/
        options = \"metadata,umask=22,fmask=11\"
        [network]
        generateHosts = true" >> /etc/wsl.conf
    fi
fi

apt update
apt install software-properties-common pwgen nano python python-pip -y
apt-add-repository --yes --update ppa:ansible/ansible
apt update
apt install ansible -y

if [ ! -f secrets_pass_file.txt ]; then
	pwgen 32 1 -y > secrets_pass_file.txt
fi