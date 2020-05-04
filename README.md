
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

* Go to roles folder under onpremise-deployment-project-example
```sh
cd ./ansible-deployment-guide/onpremise-deployment-project-example/roles
```

* Download all the following Experitest Official roles to the roles folder using git (change to required version branch):

```sh
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-server.git cloud-server -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-app-signer.git app-signer -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-file-storage.git file-storage -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-regional-proxy.git regional-proxy -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-agent.git cloud-agent -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-reporter.git reporter -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-nv.git cloud-nv -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-selenium-agent.git selenium-agent -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-emulator-host.git cloud-emulator-host -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-audioservice-cloudagent.git audioservice-cloudagent -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-java8.git java8 -b 20.1
git clone https://github.com/ExperitestOfficial/ansible-role-disk-space-validator.git disk-space-validator
```

* Copy the onpremise-deployment-project-example folder to the shared folder of ansible control machine (for e.g. /shared/experitest/onpremise-deployment-project-example)

* Update the inventories/cloud1/hosts.ini file (add your servers ip and credentials)

* Provide the configuration details in inventories/group_vars/all.yml file or directly update to playbooks.

* From onpremise-deployment-project-example folder, check the connections with the target machines.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini check-connection.yml
```

* If there are multiple Experitest onpremise clouds, than create another folder inside inventories and perform the same configuration steps for new cloud hosts.ini file.

## Update Ansible Roles to another version:

* From machine which has internet connection and git client installed, create roles folder.
```sh
mkdir roles
cd roles
```

* Download all the following Experitest Official roles to the roles folder using git (change to required version branch):

```sh
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-server.git cloud-server -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-app-signer.git app-signer -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-file-storage.git file-storage -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-regional-proxy.git regional-proxy -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-agent.git cloud-agent -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-reporter.git reporter -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-nv.git cloud-nv -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-selenium-agent.git selenium-agent -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-cloud-emulator-host.git cloud-emulator-host -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-audioservice-cloudagent.git audioservice-cloudagent -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-java8.git java8 -b 20.2
git clone https://github.com/ExperitestOfficial/ansible-role-disk-space-validator.git disk-space-validator
```

* Copy the new roles folder to ansible controller shared drive and replace it with existing roles folder under onpremise-deployment-project-example folder.


## Install Java role:
* From machine which has internet connection, download java8 offline installer.

```sh
https://devops-artifacts.experitest.com/java/linux/jre1.8.0_221-linux-x64.tar.gz
```

* Create java/linux folder inside shared experitest folder for java installers (for e.g. /shared/experitest/java/linux)

* Copy the jre1.8.0_221-linux-x64.tar.gz file to the shared experitest folder inside java/linux/ folder path on ansible control machine (for e.g. /shared/experitest/java/linux/jre1.8.0_221-linux-x64.tar.gz)

* From ansible controller machine, update java8 playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/) and run the playbook.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini java8.yml
```

## Install CloudServer role:

### Prerequisites:

* SSH service should be running on the cloudserver machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Postgresql Server is not a part of ansible deployment, it should be pre-installed and configured on cloud server.

* Java role should be installed.

### Requirements:

- On any machine which has internet connection, download prereq_linux_common.zip file from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_common.zip

- Copy and unzip the downloaded prereq_linux_common.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/prereq_linux_common)

### Install CloudServer

* On any machine which has internet connection, download cloud-server dist-Linux-SERVER-{version}.zip installer file (validate the latest app_version build from cloudserver role from github)

```sh
https://devops-artifacts.experitest.com/cloud-server/linux/dist-Linux-SERVER-20.2.8326.zip
```

* Create cloud-server/linux folder inside shared experitest folder for cloudserver installers (for e.g. /shared/experitest/cloud-server/linux)

* Copy the cloud-server dist-Linux-SERVER-{version}.zip file to the shared experitest folder inside cloud-server/linux folder path on ansible control machine (for e.g. /shared/experitest/cloud-server/linux/dist-Linux-SERVER-20.2.8326.zip)

* From ansible controller machine, update cloudserver.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook with downloaded app_version.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini cloudserver.yml -e app_version=20.2.8326
```

## Install Region Proxy role:

### Prerequisites:

* SSH service should be running on the regionproxy machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Requirements:

- On any machine which has internet connection, download prereq_linux_common.zip file from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_common.zip

- Copy and unzip the downloaded prereq_linux_common.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/prereq_linux_common)

- On any machine which has internet connection, download prereq_linux_nginx.zip file from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_nginx.zip

- Copy and unzip the downloaded prereq_linux_nginx.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/prereq_linux_nginx)

### Install RegionProxy

* On any machine which has internet connection, download regionalproxy dist-Linux-PROXY-{version}.zip installer file (validate the latest app_version build from regional proxy role from github)

```sh
https://devops-artifacts.experitest.com/regional-nginx/linux/dist-Linux-PROXY-20.2.8326.zip
```

* Create regional-nginx/linux folder inside shared experitest folder for regionproxy installers (for e.g. /shared/experitest/regional-nginx/linux)

* Copy the regionproxy dist-Linux-PROXY-{version}.zip file to the shared experitest folder inside regional-nginx/linux folder path on ansible control machine (for e.g. /shared/experitest/regional-nginx/linux/dist-Linux-PROXY-20.2.8326.zip)

* From ansible controller machine, update proxy.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook with downloaded app_version.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini proxy.yml -e app_version=20.2.8326
```

## Install Application Signer role:

### Prerequisites:

* SSH service should be running on the appsigner machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Requirements:

- On any machine which has internet connection, download prereq_linux_common.zip file from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_common.zip

- Copy and unzip the downloaded prereq_linux_common.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/prereq_linux_common)

### Install Application Signer

* On any machine which has internet connection, download app-signer dist-Linux-SIGNER-{version}.zip installer file (validate the latest app_version build from appsigner role from github)

```sh
https://devops-artifacts.experitest.com/app-signer/linux/dist-Linux-SIGNER-20.2.8326.zip
```

* Create app-signer/linux folder inside shared experitest folder for appsigner installers (for e.g. /shared/experitest/app-signer/linux)

* Copy the app-signer dist-Linux-SIGNER-{version}.zip file to the shared experitest folder inside app-signer/linux folder path on ansible control machine (for e.g. /shared/experitest/app-signer/linux/dist-Linux-SIGNER-20.2.8326.zip)

* From ansible controller machine, update appsigner.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook with downloaded app_version.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini appsigner.yml -e app_version=20.2.8326
```

## Install File Storage role:

### Prerequisites:

* SSH service should be running on the filestorage machine and ssh user was added to sudoers file with NOPASSWD: ALL privileges.

* Java role should be installed.

### Requirements:

- On any machine which has internet connection, download prereq_linux_common.zip file from below url <br>
https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_common.zip

- Copy and unzip the downloaded prereq_linux_common.zip file to ansible master (control machine) shared/nfs folder (for e.g. /shared/experitest/prereq_linux_common)

### Install File Storage

* On any machine which has internet connection, download file-storage dist-Linux-STORAGE-{version}.zip installer file (validate the latest app_version build from filestorage role from github)

```sh
https://devops-artifacts.experitest.com/file-storage/linux/dist-Linux-STORAGE-20.2.8326.zip
```

* Create file-storage/linux folder inside shared experitest folder for filestorage installers (for e.g. /shared/experitest/file-storage/linux)

* Copy the file-storage dist-Linux-STORAGE-{version}.zip file to the shared experitest folder inside file-storage/linux folder path on ansible control machine (for e.g. /shared/experitest/file-storage/linux/dist-Linux-STORAGE-20.2.8326.zip)

* From ansible controller machine, update filestorage.yml playbook (for e.g. set deployment_mode: offline and shared_storage_folder: /shared/experitest/ and set the other required parameters.) and run the playbook with downloaded app_version.

```sh
ansible-playbook -i inventories/cloud1/hosts.ini filestorage.yml -e app_version=20.2.8326
```
