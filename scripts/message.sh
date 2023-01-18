#!/bin/bash

BOLDGREEN='\033[1;32m'
NOCOLOR='\033[0m' # No Color

echo -e '\n '$BOLDGREEN $DOCKER_IMAGE_NAME:$VERSION $NOCOLOR' \n'

echo -e '\n List of services available in this container\n'

GREEN='\033[0;32m'
echo -e $GREEN'   Jupyter\n'$NOCOLOR

jupyter server list

echo -e $GREEN'\n   Rstudio\n'$NOCOLOR

echo -e 'http://'$HOST_NAME':'$RSPORT'\n\n'