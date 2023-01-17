#!/bin/bash

cat container_name.txt

echo -e '\n List of services available in this container\n'

echo -e '\n   Jupyter\n'

jupyter server list

echo -e '\n   Rstudio\n'

echo -e '\n http://$HOST_NAME:$RSPORT'