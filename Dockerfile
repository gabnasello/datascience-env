FROM quay.io/jupyter/r-notebook:2023-12-14

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2024-06-12' 

# Copy examples directory
COPY --chown=jovyan:jovyan examples/ /home/jovyan/examples/

# Remove work directory
RUN rm -r /home/jovyan/work

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

USER root
# Install Cmake (required by some R packages, like ggpubr)
RUN apt update && apt -y install cmake

USER jovyan

# Install R packages
ADD install_r_packages.R /
RUN git clone https://github.com/gabnasello/ggplotUtils.git
RUN git clone https://github.com/gabnasello/statsUtils.git
RUN Rscript /install_r_packages.R
RUN rm -r ggplotUtils/ /home/jovyan/ggplotUtils*.tar.gz statsUtils/ /home/jovyan/statsUtils*.tar.gz

# Add "jl" command
RUN echo "alias jl='jupyter server list'" >> ~/.bashrc