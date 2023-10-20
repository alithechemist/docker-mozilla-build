#!/bin/bash
#
#
set -x

VERSION="115.3.1"
BASEDIR="/home/g/Projects/gnuzilla/"
DATADIR="${BASEDIR}/data"
SRCDIR="${BASEDIR}/output/icecat-${VERSION}"


# Build docker image with

mkdir -p testbuild
docker build testbuild -t mozilla-build:test -f Dockerfile


# The mozconfig is outide of the volume so we copy it first 
# Todo: mount another volume and perform these operation from within the container

#moving to Dockerfile
#cp ${DATADIR}/buildscripts/mozconfig-common ${SRCDIR}/.mozconfig
#cat ${DATADIR}/buildscripts/mozconfig-gnulinux >> ${SRCDIR}/.mozconfig

# Run with:
docker run -v ${SRCDIR}:/usr/local/src/icecat -v ${BASEDIR}:/usr/local/src/icecat_root -it mozilla-build:test
