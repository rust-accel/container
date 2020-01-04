#!/bin/bash

cat << EOF
name: Docker
on: [push]
jobs:
EOF

for CENTOS_VERSION in 6 7; do
  for CUDA_VERSION in 8.0 9.0 9.1 9.2 10.0 10.1 10.2; do
    tag="centos${CENTOS_VERSION}-cuda${CUDA_VERSION}"
cat << EOF
  ${tag}:
    runs-on: ubuntu-latest
    name: CentOS ${CENTOS_VERSION}, CUDA ${CUDA_VERSION}
    steps:
      - uses: actions/checkout@master
      - name: Login GitHub Registry
        run: docker login docker.pkg.github.com -u owner -p \${{ secrets.GITHUB_TOKEN }}
      - name: Build image
        run: make ${tag}
EOF
  done
done

UBUNTU_VERSION=16.04
for CUDA_VERSION in 8.0 9.0 9.1 9.2 10.0 10.1 10.2; do
  tag="ubuntu${UBUNTU_VERSION}-cuda${CUDA_VERSION}"
cat << EOF
  ${tag}:
    runs-on: ubuntu-latest
    name: Ubuntu ${UBUNTU_VERSION}, CUDA ${CUDA_VERSION}
    steps:
      - uses: actions/checkout@master
      - name: Login GitHub Registry
        run: docker login docker.pkg.github.com -u owner -p \${{ secrets.GITHUB_TOKEN }}
      - name: Build image
        run: make ${tag}
EOF
done

UBUNTU_VERSION=18.04
for CUDA_VERSION in 9.2 10.0 10.1 10.2; do
  tag="ubuntu${UBUNTU_VERSION}-cuda${CUDA_VERSION}"
cat << EOF
  ${tag}:
    runs-on: ubuntu-latest
    name: Ubuntu ${UBUNTU_VERSION}, CUDA ${CUDA_VERSION}
    steps:
      - uses: actions/checkout@master
      - name: Login GitHub Registry
        run: docker login docker.pkg.github.com -u owner -p \${{ secrets.GITHUB_TOKEN }}
      - name: Build image
        run: make ${tag}
EOF
done
