#! /usr/bin/env bash

set -x
set -e

#a=$1

#ARCH="${a:1}"

#echo $ARCH

arch=$1

ARCH="${arch:1}"
echo $ARCH

# Wait for docker pull to complete downloading container
if [ $ARCH == 'aarch64' ]; then
  manylinux_image="ghcr.io/pyca/cryptography-manylinux2014_${ARCH}"
else
  manylinux_image="ghcr.io/pyca/cryptography-manylinux2014:${ARCH}"
fi
docker pull "${manylinux_image}" &
wait

# Build wheels
docker run --rm -v `pwd`:/io/src "${manylinux_image}" /io/src/travis/build-manylinux-wheels.sh &
wait
