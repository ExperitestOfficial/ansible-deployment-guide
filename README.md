
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
cd /shared/experitest/experitest-ansible-offline-installation)
```

```sh

# for centos / rhel
pip3 install ./linux/pip3/ansible-offline/*
pip3 install ./linux/pip3/pywinrm-offline/*
sudo yum localinstall -y ./linux/sshpass/*

# for mac
pip3 install ./mac/pip3/ansible-offline/*
pip3 install ./mac/pip3/pywinrm-offline/*
cd  ./mac/sshpass
sh sshpass-install.sh

```

* check the ansible version <br>
`ansible --version`

* [genereate \ add ssh key](https://github.com/ExperitestOfficial/ansible-deployment-guide/blob/master/prerequisites/SSH.md)


## Flow Diagram:
![myimage-alt-tag](https://github.com/ExperitestOfficial/ansible-deployment-guide/blob/onpremise-deployment-project-example/onpremise-deploy-without-internet/Ansible%20OnPremises%20Flow%20Diagram%20v1.2.png)

<br>

## Install Ansible Project and Roles:

* From machine which has internet connection and git client installed, download ansible-deployment-guide repository.
```sh
git clone https://github.com/ExperitestOfficial/ansible-deployment-guide.git -b onpremise-deployment-project-example
```

* Go to roles folder under onpremise-deployment-project-example
```sh
cd ./ansible-deployment-guide/onpremise-deploy-without-internet/roles
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

* Update the inventories/hosts.ini file (add your servers ip and credentials)

* Provide the configuration details in inventories/group_vars/all.yml file or directly update to playbooks.

* From onpremise-deployment-project-example folder, check the connections with the target machines.

```
ansible-playbook -i inventories/hosts.ini check-connection.yml
```


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
