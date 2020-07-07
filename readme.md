# Installed software
* Apache2
* PHP7.4
* MariaDB
* NVM
* Homebrew
* PHPMyAdmin
* Wordpress
* Mailhog

# Ansible system setup
How to install ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu

Debian / Ubuntu:  
* `sudo apt update`  
* `sudo apt install software-properties-common pwgen nano python python-pip -y`  
* `sudo apt-add-repository --yes --update ppa:ansible/ansible`  
* `sudo apt update`  
* `sudo apt install ansible`  
* `ansible-playbook setup-system.yml`

or 
* `sudo ./bin/ansible_setup.sh`
* `ansible-playbook setup-system.yml`

Now start powershell and reset distribution
* `wsl -l` to list all distributions
* `wsl -t <DistributionName>`

## Sites setup

### Databases
* Edit `setup-hosts.yml`
* add records to variable `created_databases`
  * database with new user `- { name: 'test', user: 'test', password: 'test' }`
  * database only `- { name: 'test2' }`

full example:
```
---
- hosts:
  - localhost
  vars:
    created_databases:
    - { name: 'test', user: 'test', password: 'test' }
    - { name: 'test2' }
```
### Domains
* Edit `setup-hosts.yml`
* add records to variable `created_domains`
  * create site config `- { name: 'site-name', domain: 'site-name.local', path: '/var/www/html' }`
* add records to variable `enabled_sites`
  * it must be name defined in `created_domains`: `- { name: 'site-name' }`

full example:
```
---
- hosts:
  - localhost
  vars:
    created_domains:
    - { name: 'site-name', domain: 'site-name.local', path: '/var/www/html' }
    enabled_sites:
    - { name: 'site-name' }
```

Add hosts to `C:\Windows\System32\drivers\etc\hosts`

### Run setup
adjust php_extensions list in setup-hosts.yml and run
`ansible-playbook setup-hosts.yml`

### Add domains do hosts file
Edit `C:\Windows\System32\drivers\etc\hosts` in text editor as administrator and add created domains
```
127.0.0.1 some-domain.local
127.0.0.1 other-domain.local
```

## Run server
`ansible-playbook run-server.yml`

## phpMyAdmin
use `http://localhost/phpmyadmin` or add `pma.local` to windows hosts file (if WSL)

## mailhog
use `http://localhost:8025` or add `mailhog.local` to windows hosts file (if WSL)

## Wordpress
To install wordpress run `ansible-playbook setup-wordpress.yml` and follow instructions