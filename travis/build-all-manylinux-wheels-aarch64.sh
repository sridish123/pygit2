set -x
set -e

# Wait for docker pull to complete downloading container
manylinux_image="ghcr.io/pyca/cryptography-manylinux2014:aarch64"
docker pull "${manylinux_image}" &
wait

# Build wheels
docker run --rm -v `pwd`:/io/src "${manylinux_image}" /io/src/travis/build-manylinux-wheels.sh &
wait
