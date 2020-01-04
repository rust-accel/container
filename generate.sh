#!/bin/bash
set -eux

ubuntu_tag () {
  echo "ubuntu${UBUNTU_VERSION//./}-cuda${CUDA_VERSION//./_}"
}

ubuntu_generate () {
  tag=$(ubuntu_tag)
  echo $tag
  sed -e "s/CUDA_VERSION/${CUDA_VERSION}/" \
      -e "s/UBUNTU_VERSION/${UBUNTU_VERSION}/" \
      < ubuntu.Dockerfile > Dockerfile
  sed -e "s/CUDA_VERSION/${CUDA_VERSION}/" \
      -e "s/OS_VERSION/${UBUNTU_VERSION}/" \
      -e "s/OS/Ubuntu/" \
      -e "s/TAG/$tag/" \
      < TEMPLATE.md > README.md
  git branch -D $tag || true
  git checkout -b $tag
  git add Dockerfile README.md
  git commit -m "Ubuntu ${UBUNTU_VERSION} with CUDA ${CUDA_VERSION}"
  git checkout -
}

centos_tag () {
  echo "centos${CENTOS_VERSION}-cuda${CUDA_VERSION//./_}"
}

centos_generate () {
  tag=$(centos_tag)
  echo $tag
  sed -e "s/CUDA_VERSION/${CUDA_VERSION}/" \
      -e "s/CENTOS_VERSION/${CENTOS_VERSION}/" \
      < centos.Dockerfile > Dockerfile
  sed -e "s/CUDA_VERSION/${CUDA_VERSION}/" \
      -e "s/OS_VERSION/${CENTOS_VERSION}/" \
      -e "s/OS/CentOS/" \
      -e "s/TAG/$tag/" \
      < TEMPLATE.md > README.md
  git branch -D $tag || true
  git checkout -b $tag
  git add Dockerfile README.md
  git commit -m "CentOS ${CENTOS_VERSION} with CUDA ${CUDA_VERSION}"
  git checkout -
}


ubuntu_tags=()
UBUNTU_VERSION=16.04
for CUDA_VERSION in 8.0 9.0 9.1 9.2 10.0 10.1 10.2; do
  ubuntu_generate
  ubuntu_tags=($(ubuntu_tag) "${ubuntu_tags[@]}")
done
UBUNTU_VERSION=18.04
for CUDA_VERSION in 9.2 10.0 10.1 10.2; do
  ubuntu_generate
  ubuntu_tags=($(ubuntu_tag) "${ubuntu_tags[@]}")
done
if [[ -n "${PUBLISH_UBUNTU:-}" ]]; then
  git push origin "${ubuntu_tags[@]}" -f
fi

centos_tags=()
for CENTOS_VERSION in 6 7; do
  for CUDA_VERSION in 8.0 9.0 9.1 9.2 10.0 10.1 10.2; do
    centos_generate
    centos_tags=($(centos_tag) "${centos_tags[@]}")
  done
done
if [[ -n "${PUBLISH_CENTOS:-}" ]]; then
  git push origin "${centos_tags[@]}" -f
fi
