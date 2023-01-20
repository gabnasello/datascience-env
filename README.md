# Docker Image for basic data science

# Build the docker image

From the project folder, run the command below:

```bash build.sh```

# Run docker container

## Standard approach (recommended)

From the project folder, run the command below:

```bash start-docker.sh```

Which automatically updates the .env and create a new Docker Image with the ```researcher``` user sharing the ID of the host user.

It is possible to detached from the container (```ctrl + D```) and connect in a second moment with:

```bash connect-docker.sh```

Close the container with:

```bash end-docker```

## docker-compose approach

Be aware that the user ```researhcer``` within you Docker container won't share the same ID as the host user!

From the project folder, run the command below:

```docker-compose up -d```

To connect to a container that is already running ("datascience" is the service name):

```docker-compose exec datascience /bin/bash```

Close the container with:

```docker-compose down```

## Alternative approach

You can run the following command:

```docker run -d -it --rm  -p 7777:7777 -p 7878:7878 --volume $HOME:/home/researcher --user root --name datascience gnasello/datascience-env:latest```

To connect to a container that is already running ("datascience" is the container name):

```docker exec -it datascience /bin/bash```

After use, you close the container with:

```docker rm -f datascience-env```