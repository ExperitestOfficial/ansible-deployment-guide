
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
sudo yum localinstall -y ./linux/extras/*

# for mac
sudo pip3 install ./mac/pip3/ansible-offline/*
sudo pip3 install ./mac/pip3/pywinrm-offline/*
cd  ./mac/extras
sh sshpass-install.sh

```

* check the ansible version <br>
`ansible --version`

* [genereate \ add ssh key](prerequisites/linux/SSH.md)


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

* From mac/linux client machines which has internet connection and git client installed, run the [project-setup.sh](project-setup.sh) script.
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

## Install Reporter role:

### Prerequisites:

* SSH service should be running on the reporter linux machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Postgresql Server is not a part of ansible deployment, it should be pre-installed and configured on reporter machine.

* Java role should be installed.

### Install Reporter

* From ansible controller machine, update reporter.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini reporter.yml
```

## Install Cloud Agent role:

### Prerequisites:

* SSH service should be running on the cloudagent linux machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* XCode is not a part of ansible deployment, it should be pre-installed on cloudagent machine.

* Java role should be installed.

### Install Cloud Agent

* From ansible controller machine, update cloudagent.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini cloudagent.yml
```

## Install Selenium Agent role:

### Prerequisites:

* For Mac Selenium Agent - SSH service should be running on the selenium agent mac machines and ssh user should added to sudoers file with NOPASSWD: ALL privileges.

* For Windows Selenium Agent - Winrm Service should be running and firewall ports 5985-5986 are open on the selenium agent windows machines. To install and configure winrm, copy the [prerequistes/windows](./prerequisites/windows) folder to selenium agent machine and run powershell as an Administrator and execute [Install-WinRM.ps1](./prerequisites/windows/Install-WinRM.ps1) script.

### Install Selenium Agent

* From ansible controller machine, update seleniumagent.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini seleniumagent.yml
```

## Install Cloud NV role:

### Prerequisites:

* SSH service should be running on the cloud-nv machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.


### Install Cloud NV

* From ansible controller machine, update nv.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini nv.yml
```


## Run all installation in parallel:

* To install all the components in parallel, execute the shell script [run-all.sh](onpremise-deployment-project-example/run-all.sh) with inventory name from project folder.

```sh
# for linux only - run the dos2unix tool first time to convert file to Unix line endings (line feed)
dos2unix run-all.sh

# example
sh run-all.sh cloud1
```
