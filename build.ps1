$DOCKERHUB_USER = "gnasello"
$CONTAINER_NAME = "datascience-env"
$VERSION = '2025-09-18'
$ARCH = "arm64" # or "amd64"

docker buildx build --no-cache --platform "linux/${ARCH}" -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}_${ARCH}" --load -f Dockerfile .