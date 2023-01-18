#!/bin/bash

# From Adding arguments and options to your Bash scripts
# https://www.redhat.com/sysadmin/arguments-options-bash-scripts

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Shortcut to copy user-specific docker files."
   echo 
   echo "Argument:"
   echo "UNUMBER"
   echo
   echo "Options:"
   echo "h     Print this Help."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

if [ $# -eq 0 ]
  then
    echo -e "\nNo arguments supplied! Please provide the name of the user or type -h for the help\n"
    exit 1
fi

# input user u-numbrer
UNUMBER=$1

# Full directory name of the script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONTAINERNAME="$(basename $SCRIPT_DIR)"


############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done


## Directory where the new user-specific docker files will be stored
USERFOLDER=/home/luna.kuleuven.be/$UNUMBER/BDcenter/$CONTAINERNAME

## Create the USERFOLDER directory if it doesn't exist yet
mkdir -p $USERFOLDER
rm $USERFOLDER/*

cp Dockerfile_usertemplate $USERFOLDER/Dockerfile_usertemplate
cp docker-compose.yaml $USERFOLDER/docker-compose.yaml
cp start-docker.sh $USERFOLDER/start-docker.sh
cp connect-docker.sh $USERFOLDER/connect-docker.sh
cp end-docker.sh $USERFOLDER/end-docker.sh
cp env_usertemplate $USERFOLDER/env_usertemplate

echo User-specific $CONTAINERNAME created!