# Ansible system setup
How to install ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu

Debian / Ubuntu:  
* `sudo apt update`  
* `sudo apt install software-properties-common pwgen python3 python3-pip`  
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

### Run setup
`ansible-playbook setup-hosts.yml`

## Run server
`ansible-playbook run-server.yml`
