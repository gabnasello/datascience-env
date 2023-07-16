# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM jupyter/r-notebook:2023-07-11

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2023-07-16' 

# How to connect all conda envs to jupyter notebook
# https://stackoverflow.com/questions/61494376/how-to-connect-r-conda-env-to-jupyter-notebook
RUN conda install -y -n base nb_conda_kernels

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

USER root
RUN apt-get update && \ 
    #apt install -yq apt-utils build-essential libfontconfig1-dev tmux cmake vim
    apt install -yq tmux cmake vim
USER jovyan

# Install R packages
ADD install_r_packages.R /
RUN Rscript /install_r_packages.R

WORKDIR /home/jovyan