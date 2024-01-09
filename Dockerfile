FROM quay.io/jupyter/r-notebook:2023-12-14

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2024-01-03' 

# Copy examples directory
COPY --chown=jovyan:jovyan examples/ /home/jovyan/examples/

# Remove work directory
RUN rm -r /home/jovyan/work

USER root
# Install Cmake (required by some R packages, like ggpubr)
RUN apt update && apt -y install cmake

# Install Rstudio Server
# RSTUDIO 
RUN RSTUDIO_URL="https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.12.0-369-amd64.deb" && \
    apt-get update && \
    apt-get -y install gdebi-core && \
    wget -O rstudio.deb $RSTUDIO_URL && \
    gdebi rstudio.deb && \
    rm rstudio.deb

USER jovyan
# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

# Install R packages
ADD install_r_packages.R /
RUN Rscript /install_r_packages.R

# Add "jl" command
RUN echo "alias jl='jupyter server list'" >> ~/.bashrc