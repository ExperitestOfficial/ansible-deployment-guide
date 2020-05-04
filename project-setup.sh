#!/bin/bash

# This script will install the experitest ansible roles
# and download the artifacts and pre-requisites on the shared folder


main()
{

	# check if git is installed
	git --version > /dev/null

	if [ $? != 0 ]
		   then
			          echo "Error: 'git is not installed on system'"
				         exit 1
				 fi


				 # get inputs from user
				 read -p "Please provide shared folder path (e.g. - /shared/experitest) : " shared_path
				 read -p "Please provide experitest release version (e.g. - 20.2) : " release_ver

				 # call install roles func
				 install_roles

			 }

			 install_roles()
			 {

				 mkdir -p $shared_path/onpremise-deployment-project-example
				 roles_path=$shared_path/onpremise-deployment-project-example/roles

				 echo "cleanup old roles"
				 rm -rf $roles_path/*

				 echo "installing roles for $release_ver version ..."

				 git clone https://github.com/ExperitestOfficial/ansible-role-cloud-server.git $roles_path/cloud-server -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-app-signer.git $roles_path/app-signer -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-file-storage.git $roles_path/file-storage -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-regional-proxy.git $roles_path/regional-proxy -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-cloud-agent.git $roles_path/cloud-agent -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-reporter.git $roles_path/reporter -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-cloud-nv.git $roles_path/cloud-nv -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-selenium-agent.git $roles_path/selenium-agent -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-cloud-emulator-host.git $roles_path/cloud-emulator-host -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-audioservice-cloudagent.git $roles_path/audioservice-cloudagent -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-java8.git $roles_path/java8 -b $release_ver
				 git clone https://github.com/ExperitestOfficial/ansible-role-disk-space-validator.git $roles_path/disk-space-validator


				 # call download pre-requisites function
			 download_prereq

		 }


		 download_prereq()
		 {

			 echo "downloading pre-requisites..."

			 # download linux common prerequisites
		 download_path=$shared_path
		 mkdir -p $shared_path

	 download_url=https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_common.zip
	 cd $download_path && { curl -O $download_url ; unzip -n prereq_linux_common.zip ; cd -; }

	 # download linux nginx
 download_path=$shared_path
 mkdir -p $shared_path

 download_url=https://devops-artifacts.experitest.com/ansible/onpremise/prereq_linux_nginx.zip
 cd $download_path && { curl -O $download_url ; unzip -n prereq_linux_nginx.zip ; cd -; }

 # download java8
 role=java
 download_path=$shared_path/$role/linux
 mkdir -p $shared_path/$role/linux

 app_ver=$(cat $roles_path/java8/defaults/main.yml | grep __java_version | awk '{print $2}')
 download_url=https://devops-artifacts.experitest.com/$role/linux/jre$app_ver-linux-x64.tar.gz
 cd $download_path && { curl -O $download_url ; cd -; }


 # call download artifacts function
 download_artifacts

 }


 download_artifacts()
 {

	 echo "downloading artifacts for linux platform..."

	 # download cloud server
	 role=cloud-server
	 component=SERVER
 download_path=$shared_path/$role/linux
 mkdir -p $shared_path/$role/linux

 app_ver=$(cat $roles_path/$role/defaults/main.yml | grep __app_version | awk '{print $2}')
 download_url=https://devops-artifacts.experitest.com/$role/linux/dist-Linux-$component-$app_ver.zip
 cd $download_path && { curl -O $download_url ; cd -; }

 # download app signer
 role=app-signer
 component=SIGNER
 download_path=$shared_path/$role/linux
 mkdir -p $shared_path/$role/linux

 app_ver=$(cat $roles_path/$role/defaults/main.yml | grep __app_version | awk '{print $2}')
 download_url=https://devops-artifacts.experitest.com/$role/linux/dist-Linux-$component-$app_ver.zip
 cd $download_path && { curl -O $download_url ; cd -; }

 # download file storage
 role=file-storage
 component=STORAGE
 download_path=$shared_path/$role/linux
 mkdir -p $shared_path/$role/linux

 app_ver=$(cat $roles_path/$role/defaults/main.yml | grep __app_version | awk '{print $2}')
 download_url=https://devops-artifacts.experitest.com/$role/linux/dist-Linux-$component-$app_ver.zip
 cd $download_path && { curl -O $download_url ; cd -; }

 # download region proxy
 role=regional-nginx
 component=PROXY
 download_path=$shared_path/$role/linux
 mkdir -p $shared_path/$role/linux

 app_ver=$(cat $roles_path/regional-proxy/defaults/main.yml | grep __app_version | awk '{print $2}')
 download_url=https://devops-artifacts.experitest.com/$role/linux/dist-Linux-$component-$app_ver.zip
 cd $download_path && { curl -O $download_url ; cd -; }

 }

 # call main function
 main

