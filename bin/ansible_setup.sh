#!/bin/bash

unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
    # WSL config
    if grep -q Microsoft /proc/sys/kernel/osrelease; then
        if [ ! -f /etc/wsl.conf ]; then    
            printf "[automount]\nenabled = true\nroot = /mnt/\noptions = \"metadata,umask=22,fmask=11\"\n[network]\ngenerateHosts = true\n" >> /etc/wsl.conf
        fi
    fi

    # Check distribution and version
    Distribution=$(lsb_release -i --short)
    Version=$(lsb_release -r --short)

    # For Debian and Ubuntu
    if [ "$Distribution" == "Ubuntu" ] || [ "$Distribution" = "Debian" ]; then
        apt -q update
        apt -q upgrade -y
        apt -qq install software-properties-common pwgen nano -y

        # Ubuntu specific operations
        if [ "$Distribution" == 'Ubuntu' ]; then
            if [ "$(printf '%s\n' "20" "$Version" | sort -V | head -n1)" != "20" ]; then
                apt -qq install python python-pip -y
                apt-add-repository --yes --update ppa:ansible/ansible
            else
                apt -qq install python3-pip -y
            fi
        fi
        # Debian specific operations
        if [ "$Distribution" == 'Debian' ]; then
            grep -qxF 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' /etc/apt/sources.list || echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' | tee -a /etc/apt/sources.list > /dev/null
            apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
            apt -q update
        fi
        apt -qq install ansible -y

        if [ ! -f secrets_pass_file.txt ]; then
            pwgen 32 1 -y > secrets_pass_file.txt
        fi
    else
        echo "This script works only with Debian and Ubuntu (for now)"
    fi
elif [[ "$unamestr" == 'Darwin' ]]; then
    sudo easy_install pip
    pip install ansible --user
    echo 'export PATH="/Users/$USER/Library/Python/2.7/bin:$PATH"' >> ~/.zshrc
    echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
fi