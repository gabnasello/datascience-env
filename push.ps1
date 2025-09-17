# PowerShell script to build and push Docker image for arm64
# Save as push.ps1 and run with PowerShell

$DOCKERHUB_USER = "gnasello"
$CONTAINER_NAME = "datascience-env"
$VERSION = "2025-09-17"
$ARCH = "arm64"  # Change to "amd64" if needed

# Build and push the image for the specified architecture
docker buildx build `
    --no-cache `
    --platform "linux/$ARCH" `
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-$ARCH" `
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" `
    -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest" `
    --push `
    -f Dockerfile .

# Instructions for creating multi-arch manifest
Write-Host "`nOnce images with both arm64 and amd64 architectures are pushed, run the following to create the multi-arch manifest:`n"
Write-Host "docker manifest create ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION} `"
Write-Host "  ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-amd64 `"
Write-Host "  ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}-arm64"
Write-Host ""
Write-Host "docker manifest push ${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}"
Write-Host "docker manifest push ${DOCKERHUB_USER}/${CONTAINER_NAME}:latest"
