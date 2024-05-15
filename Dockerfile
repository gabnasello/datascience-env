FROM quay.io/jupyter/r-notebook:2023-12-14

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2024-05-15' 

# Copy examples directory
COPY --chown=jovyan:jovyan examples/ /home/jovyan/examples/

# Remove work directory
RUN rm -r /home/jovyan/work

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

# Install R packages
ADD install_r_packages.R /
RUN Rscript /install_r_packages.R

# Add "jl" command
RUN echo "alias jl='jupyter server list'" >> ~/.bashrc