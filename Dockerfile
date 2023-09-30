FROM lscr.io/linuxserver/webtop:amd64-ubuntu-kde-version-0f29909a
#FROM lscr.io/linuxserver/webtop:amd64-ubuntu-icewm-version-f91f0828

# sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install wine32 winetricks -y
# wineboot
# winetricks win10

# Configure environment
ENV DOCKER_IMAGE_NAME='datascience-env'
ENV VERSION='2023-09-27' 

# title
ENV TITLE=DataScience

# ports and volumes
EXPOSE 3000

# ports and volumes
EXPOSE 8888

VOLUME /config

RUN apt-get update && \
    apt-get install -y vim git\ 
                       python-is-python3 \
                       python3-pip

# Install Python packages
ADD requirements.txt /
RUN pip install -r /requirements.txt

# Install R
RUN apt update && \
    apt install r-base r-base-dev -y

# Install R packages
ADD install_r_packages.R /
RUN Rscript /install_r_packages.R

RUN chmod 777 -R /config/

#COPY /desktop/jupyter.desktop /usr/share/applications/
COPY /desktop/jupyter.desktop /config/Desktop/
RUN chmod 777 /config/Desktop/jupyter.desktop