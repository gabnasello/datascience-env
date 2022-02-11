# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM jupyter/r-notebook:latest

# Install Python packages
ADD requirements.txt .
RUN pip install -r requirements.txt

# Set the jl command to create a JupytetLab shortcut
EXPOSE 7777
RUN echo "alias jl='export SHELL=/bin/bash; jupyter lab --allow-root --port=7777 --ip=0.0.0.0'" >> ~/.bashrc

USER root
RUN apt-get update && \ 
    apt install -yq apt-utils libfontconfig1-dev tmux cmake vim
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
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.2-382-amd64.deb  && \
    gdebi -n rstudio-server-2021.09.2-382-amd64.deb && \
    rm rstudio-server-2021.09.2-382-amd64.deb

# Change default port for Rstudio server to 7878
# Give the rstudio user sudo priviledges without asking for a password (only sudo commando from rstudio terminal)
EXPOSE 7878
# https://s3.amazonaws.com/rstudio-server/rstudio-server-pro-0.98.507-admin-guide.pdf
RUN echo "www-port=7878" > /etc/rstudio/rserver.conf && \
    usermod -aG sudo rstudio && \
    echo 'jovyan ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD launch_rstudio_server.sh .
RUN echo "alias rs='bash /launch_rstudio_server.sh'" >> ~/.bashrc

