#!/bin/bash

VERSION='2024-06-12'

docker build --no-cache -t gnasello/datascience-env:$VERSION .
