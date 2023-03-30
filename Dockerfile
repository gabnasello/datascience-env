# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM jupyter/r-notebook:2023-03-27

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2023-03-29' 

# Docker name to shell prompt
ENV PS1A="[docker] \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
RUN echo 'PS1=$PS1A' >> ~/.bashrc
RUN echo 'conda activate base' >> ~/.bashrc

# How to connect all conda envs to jupyter notebook
# https://stackoverflow.com/questions/61494376/how-to-connect-r-conda-env-to-jupyter-notebook
RUN conda install -y -n base nb_conda_kernels

# Install Python packages
ADD requirements.txt .
RUN pip install -r requirements.txt

# Set the jl command to create a JupytetLab shortcut
ADD scripts/launch_jupyterlab.sh /
RUN echo "alias jl='bash /launch_jupyterlab.sh'" >> ~/.bashrc

USER root
RUN apt-get update && \ 
    apt install -yq apt-utils build-essential libfontconfig1-dev tmux cmake vim
USER jovyan

# Install R packages
ADD install_r_packages.R .
RUN Rscript install_r_packages.R


# Install R Studio Server
USER root

#Create and rstudio user account to login to RStudio Server
RUN useradd -ms /bin/bash rstudio && \
    echo 'rstudio:rstudio' | chpasswd

WORKDIR /
RUN apt-get install -yq gdebi-core  && \
    wget https://s3.amazonaws.com/rstudio-ide-build/server/jammy/amd64/rstudio-server-2022.12.0-preview-314-amd64.deb  && \
    gdebi -n rstudio-server-2022.12.0-preview-314-amd64.deb && \
    rm rstudio-server-2022.12.0-preview-314-amd64.deb

# Change default port for Rstudio server to 7878
# Give the rstudio user sudo priviledges without asking for a password (only sudo commando from rstudio terminal)
EXPOSE 7878
# https://s3.amazonaws.com/rstudio-server/rstudio-server-pro-0.98.507-admin-guide.pdf
RUN echo "www-port=7878" > /etc/rstudio/rserver.conf && \
    usermod -aG sudo rstudio && \
    echo 'jovyan ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER jovyan

ADD scripts/launch_rstudio_server.sh .
RUN echo "alias rs='bash /launch_rstudio_server.sh'" >> ~/.bashrc

ADD scripts/entrypoint.sh .
ADD scripts/message.sh .
RUN echo "bash /message.sh" >> ~/.bashrc