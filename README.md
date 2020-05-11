
# Experitest - Ansible Deployments Guide

Experitest is a **private company**, creating software to manage enterprise level Mobile Device Lab - for automating mobile application and web testing.

This repo contains **Onpremise deployment** for using ansible to deploy experitest products without internet on ansible control machine:

# Prepare Ansible Control Machine - Without internet

## Requirements:

- Make sure python3.6, pip3 and unzip tools is already installed on Linux or Mac control machines

- Make sure the shared folder mapped to ansible controller machine (for e.g. /shared/experitest)

- On any machine which has internet connection, download offline ansible installation from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/experitest-ansible-offline-installation.zip

- Copy and unzip the downloaded experitest-ansible-offline-installation.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/experitest-ansible-offline-installation)


## Install Ansible:

* Login to ansible controller machine and go to the downloaded extracted folder inside shared folder and install ansible (depending on distribution) using below commands.

```sh

# for example
cd /shared/experitest/experitest-ansible-offline-installation

```

```sh

# for centos / rhel
sudo pip3 install ./linux/pip3/ansible-offline/*
sudo pip3 install ./linux/pip3/pywinrm-offline/*
sudo yum localinstall -y ./linux/sshpass/*

# for mac
sudo pip3 install ./mac/pip3/ansible-offline/*
sudo pip3 install ./mac/pip3/pywinrm-offline/*
cd  ./mac/sshpass
sh sshpass-install.sh

```

* check the ansible version <br>
`ansible --version`

* [genereate \ add ssh key](SSH.md)


## Flow Diagram:
![myimage-alt-tag](Ansible%20OnPremises%20Flow%20Diagram%20v1.2.png)

<br>

## Install Ansible Project and Roles:

* From machine which has internet connection and git client installed, download ansible-deployment-guide repository.
```sh
git clone https://github.com/ExperitestOfficial/ansible-deployment-guide.git -b onpremise-deployment-project-example
```

* Copy the onpremise-deployment-project-example folder to the shared folder of ansible control machine (for e.g. /shared/experitest/onpremise-deployment-project-example)

### From mac/linux client machines which has internet connections
* run the [project-setup.sh](project-setup.sh) script under ansible-deployment-guide folder to install roles and download prerequisites and artifacts to shared folder. It will prompt you to provide shared folder path and release version.  (for e.g. shared_path /shared/experitest and release_version 20.2)

```sh
/bin/sh project-setup.sh
```

### From windows client machines which has internet connections
* run the [project-setup.bat](project-setup.bat) script under ansible-deployment-guide folder to install roles and download prerequisites and artifacts to shared folder. It will prompt you to provide shared folder path and release version. (for e.g. shared_path \\\192.168.0.11\shared\experitest and release_version 20.2)

```sh
project-setup.bat
```

* Update the inventories/cloud1/hosts.ini file (add your servers ip and credentials)

* Provide the configuration details in inventories/group_vars/all.yml file or directly update to playbooks.

* From onpremise-deployment-project-example folder, check the connections with the target machines.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini check-connection.yml
```

* If there are multiple Experitest onpremise clouds, than create another folder inside inventories and perform the same configuration steps for new cloud hosts.ini file.

## Update Ansible Roles to another version:

* From mac/linux client machines which has internet connection and git client installed, run the project-setup.sh script.
```sh
/bin/sh project-setup.sh
```

* From windows client machines which has internet connection and git client installed, run the project-setup.bat script.
```sh
project-setup.bat
```

* The project setup script will prompt to enter shared folder path and release version. It will remove old roles and copy the latest roles of that version to shared folder path inside "onpremise-deployment-project-example/roles" folder.


## Install Java role:

* From ansible controller machine, update java8 playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini java8.yml
```

## Install CloudServer role:

### Prerequisites:

* SSH service should be running on the cloudserver machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Postgresql Server is not a part of ansible deployment, it should be pre-installed and configured on cloud server.

* Java role should be installed.

### Install CloudServer

* From ansible controller machine, update cloudserver.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini cloudserver.yml
```

## Install Region Proxy role:

### Prerequisites:

* SSH service should be running on the regionproxy machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Install RegionProxy

* From ansible controller machine, update proxy.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini proxy.yml
```

## Install Application Signer role:

### Prerequisites:

* SSH service should be running on the appsigner machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Install Application Signer

* From ansible controller machine, update appsigner.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini appsigner.yml
```

## Install File Storage role:

### Prerequisites:

* SSH service should be running on the filestorage machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Install File Storage

* From ansible controller machine, update filestorage.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini filestorage.yml
```
