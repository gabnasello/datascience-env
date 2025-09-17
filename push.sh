#!/bin/bash
DOCKERHUB_USER="gnasello"
CONTAINER_NAME="datascience-env"
VERSION="2025-09-17"

# Build and push multi-arch image
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" \
  -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest" \
  --push \
  -f Dockerfile .
