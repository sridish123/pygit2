#! /usr/bin/env bash

set -x
set -e

echo $1

ARCH="${1:-x86_64}"

echo $ARCH

# Wait for docker pull to complete downloading container
manylinux_image="ghcr.io/pyca/cryptography-manylinux2014${ARCH}"
docker pull "${manylinux_image}" &
wait

# Build wheels
docker run --rm -v `pwd`:/io/src "${manylinux_image}" /io/src/travis/build-manylinux-wheels.sh &
wait
