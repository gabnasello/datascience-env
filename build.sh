#!/bin/bash
DOCKERHUB_USER="gnasello"
CONTAINER_NAME="datascience-env"
VERSION="2025-09-18"
ARCH="amd64"  # or "arm64"

# Build and load the image for the specified architecture
docker buildx build \
    --no-cache \
    --platform "linux/${ARCH}" \
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-${ARCH}" \
    --load \
    -f Dockerfile .
