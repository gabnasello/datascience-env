# Docker Image for basic data science

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gabnasello/datascience-env/HEAD)

# Build the Docker Image

From the project folder, run the command below:

```bash build.sh```

# Run Docker container

## docker-compose approach (recommended)

Be aware that the user ```researcher``` within you Docker container won't share the same ID as the host user!

From the project folder, run the command below:

```docker-compose up```

## Alternative approach

You can run the following command:

```docker run -it --rm  -p 8888:8888 --volume $HOME:/home/researcher --user root --name datascience gnasello/datascience-env:latest```