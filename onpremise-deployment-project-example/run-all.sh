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
    for component in ${allComponents[*]}; do
        printresults $component
    done
  
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
    RED='\033[0;31m'
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    GRAY='\033[0;90m' 
    NC='\033[0m' # No Color

    if grep -q 'skipping: no hosts matched' ./log/$INVENTORY_NAME/$TIMESTAMP/$1.log;
    then
        echo -e "${GRAY}$1 no hosts${NC}";
    elif grep -q failed=1 ./log/$INVENTORY_NAME/$TIMESTAMP/$1.log;
    then
        echo -e "${RED}$1 failed${NC}";
    elif grep -q unreachable=1 ./log/$INVENTORY_NAME/$TIMESTAMP/$1.log;
    then
        echo -e "${BLUE}$1 unreachable${NC}";
    else
        echo -e "${GREEN}$1 passed${NC}";
    fi
}


# execute main function
main
