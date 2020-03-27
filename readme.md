# Ansible system setup
How to install ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu

Debian / Ubuntu:  
* `sudo apt update`  
* `sudo apt install software-properties-common pwgen nano python python-pip -y`  
* `sudo apt-add-repository --yes --update ppa:ansible/ansible`  
* `sudo apt update`  
* `sudo apt install ansible`  
* `pwgen 32 1 -y > secrets_pass_file.txt`  
* `ansible-vault create secrets.yml` or `EDITOR=nano ansible-vault create secrets.yml` to use nano instead of vim  
* insert sudo password `sudo_password: <your-password>` and save  
* `ansible-playbook setup-system.yml`

or 
* `sudo ./bin/ansible_setup.sh`
* `ansible-vault create secrets.yml` or `EDITOR=nano ansible-vault create secrets.yml` to use nano instead of vim  
* insert sudo password `sudo_password: <your-password>` and save  
* `ansible-playbook setup-system.yml`

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
use `http://localhost/phpmyadmin` or run `ansible-playbook setup-hosts.yml` and add `pma.local` to windows hosts file
