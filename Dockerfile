# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM jupyter/r-notebook:latest

# Install Python packages
ADD requirements.txt .
RUN pip install -r requirements.txt

# Set the jl command to create a JupytetLab shortcut
EXPOSE 7777
RUN echo "alias jl='export SHELL=/bin/bash; jupyter lab --allow-root --port=7777 --ip=0.0.0.0'" >> ~/.bashrc

# Install R packages
ADD install_r_packages.R .
RUN Rscript install_r_packages.R