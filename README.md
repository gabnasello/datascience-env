# Create a Docker Image for basic data science

## How it works

- The ```Dockerfile``` creates a Docker Image based on  [jupyter/r-notebook](https://hub.docker.com/r/jupyter/r-notebook).
- It adds Python packages jupyterlab 
- It adds R packages

## Create a new image

First, clone the repo:

```git clone https://github.com/gabnasello/datascience-env.git``` 

and run the following command to build the image (you might need sudo privileges):

```docker build --no-cache -t datascience-env:latest .```

Then you can follow the instructions in the [Docker repository](https://hub.docker.com/repository/docker/gnasello/datascience-env) to use the virtual environment.

Enjoy data science!