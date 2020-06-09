#!/bin/bash

# Experitest - Run All installations in parallel
# This script will install all the experitest component in parallel


## Set component to install - Comment the not required component with #
allComponents=(
  cloudserver
  proxy
  appsigner
  filestorage
  cloudagent
  reporter
  nv
  seleniumagent
# cloudehm
# audioservice-cloudgent
)

INVENTORY_NAME=$1

if [ -z "$INVENTORY_NAME" ]; then
  echo "\$INVENTORY_NAME is empty, please provide inventory name with script"
  exit
elif [ ! -f "inventories/$INVENTORY_NAME/hosts.ini" ]; then
  echo "inventory file not found in inventories/$INVENTORY_NAME/hosts.ini path, check if inventory name is correct and file exists"
  exit
else
  echo "will update inventory $INVENTORY_NAME"
fi


function main() {

    ## execute installall function
    while true; do
        read -p "Do you wish to continue? [Yy/Nn] " yn
        case $yn in
            [Yy]* ) installall; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer y or n.";;
        esac
    done
    
    echo -e "\n---- Printing results ---- \n"

    ## execute printresults function
    printresults

  
}


function installall() {  
    
    TIMESTAMP=$(date +%Y-%m-%d_%H.%M.%S)

    mkdir -p ./log/$INVENTORY_NAME/$TIMESTAMP

    echo "updating inventory $INVENTORY_NAME, logs written to: /log/$INVENTORY_NAME/$TIMESTAMP"

    # run processes and store pids in array
    i=0;
    for component in ${allComponents[*]}; do
        time ansible-playbook $component.yml -i inventories/$INVENTORY_NAME/hosts.ini >> ./log/$INVENTORY_NAME/$TIMESTAMP/$component.log 2>&1 &
        pids[$i]=$!
        ((i=i+1))
    done

    # wait for all pids
    for pid in ${pids[*]}; do
        wait $pid
    done

    sleep 3

}


function printresults() {

    alllogs=($(find ./log/$INVENTORY_NAME/$TIMESTAMP -type f -name '*.log'))

    for logfile in ${alllogs[*]}; do

        echo $logfile

        if grep -q 'skipping: no hosts matched' $logfile; then
          grep -B 1 "skipping: no hosts matched" $logfile
          echo ""
        elif grep -q 'ERROR! the playbook' $logfile; then
          grep 'ERROR! the playbook' $logfile
          echo ""
        elif grep -q 'PLAY RECAP' $logfile; then
          grep -A 500 "PLAY RECAP" $logfile
        else
          tail -5 $logfile
          echo -e "Check the logs file for details. \n"
        fi

        echo -e "--------------------------------------------------------------------------------\n"
    done

    echo -e "for more details check the logs from path: ./log/$INVENTORY_NAME/$TIMESTAMP "

}



# execute main function
main
