FROM quay.io/jupyter/r-notebook:2024-10-22

# Configure environment
ENV DOCKER_IMAGE_NAME='gnasello/datascience-env'
ENV VERSION='2025-09-17' 

# Add README file
# ADD README.ipynb /home/jovyan/
COPY --chown=jovyan:users README.ipynb /home/jovyan/

# Remove work directory
RUN rm -r /home/jovyan/work

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

USER root
# Install Cmake (required by some R packages, like ggpubr)
# RUN apt update && apt -y install cmake
RUN apt-get update && apt-get install -y \
    cmake \
    libfontconfig1-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libpng-dev \
    pkg-config \
    build-essential


USER jovyan

# Install R packages
ADD install_r_packages.R /
RUN git clone https://github.com/gabnasello/ggplotUtils.git
RUN git clone https://github.com/gabnasello/statsUtils.git
RUN git clone https://github.com/gabnasello/dataprepUtils.git
RUN Rscript /install_r_packages.R
RUN rm -r ggplotUtils/ /home/jovyan/ggplotUtils*.tar.gz statsUtils/ /home/jovyan/statsUtils*.tar.gz dataprepUtils/ /home/jovyan/dataprepUtils*.tar.gz

# Add "jl" command
RUN echo "alias jl='jupyter server list'" >> ~/.bashrc