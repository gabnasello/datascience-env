FROM lscr.io/linuxserver/webtop:amd64-ubuntu-kde-version-0f29909a

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2023-10-17' 

# title
ENV TITLE=DataScience

# ports and volumes
EXPOSE 3000

# ports and volumes
EXPOSE 8888

VOLUME /config

RUN apt-get update && \
    apt-get install -y vim git wget\ 
                       python-is-python3 \
                       python3-pip

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

# Install cmake and libfontconfig1 (necessary for some R packages)
RUN apt update && \
    apt install libfontconfig1-dev cmake -y

# Install R on Ubuntu from CRAN Repository
# https://phoenixnap.com/kb/install-r-ubuntu

RUN apt update && \
    apt install software-properties-common dirmngr -y && \
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc  && \
    gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
    apt install r-base r-base-dev -y

# Install R packages
ADD install_r_packages.R /
RUN Rscript /install_r_packages.R

RUN chmod 777 -R /config/

#COPY /desktop/jupyter.desktop /usr/share/applications/
COPY /desktop/jupyter.desktop /config/Desktop/
RUN chmod 777 /config/Desktop/jupyter.desktop