#!/bin/bash
# docker buildx create --name multiarch-builder --use
# chmod +x ./push.sh
DOCKERHUB_USER="gnasello"
CONTAINER_NAME="datascience-env"
VERSION="2025-09-17"
ARCH="amd64"  # or "arm64"

# Build and load the image for the specified architecture
docker buildx build \
    --no-cache \
    --platform "linux/${ARCH}" \
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-${ARCH}" \
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" \
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest" \
    --push \
    -f Dockerfile .

# Optional: Create and push multi-arch manifest (run only after both builds are pushed)
echo "Once images with both arm64 and amd64 architectures are pushed, run the following to create the multi-arch manifest:"
echo ""
echo "docker manifest create ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION} \\"
echo "  ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-amd64 \\"
echo "  ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-arm64"
echo ""
echo "docker manifest push ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}"
echo "docker manifest push ${DOCKERHUB_USER}/${CONTAINER_NAME}:latest"
