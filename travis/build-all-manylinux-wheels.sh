#! /usr/bin/env bash

set -x
set -e

# Wait for docker pull to complete downloading container
if [ `uname -m` == 'aarch64' ]; then
  manylinux_image="quay.io/pypa/manylinux2014_aarch64"
else
  manylinux_image="ghcr.io/pyca/cryptography-manylinux2014_aarch64"
fi
docker pull "${manylinux_image}" &
wait

# Build wheels
docker run --rm -v `pwd`:/io/src "${manylinux_image}" /io/src/travis/build-manylinux-wheels.sh &
wait
