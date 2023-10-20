#!/bin/bash
#
#
set -x

# Only setting needed!
BASEDIR="/home/g/Projects/gnuzilla/"

DATADIR="${BASEDIR}/data"

MAJOR=$(grep "readonly FFMAJOR" ${BASEDIR}/makeicecat | cut -d "=" -f 2)
MINOR=$(grep "readonly FFMINOR" ${BASEDIR}/makeicecat | cut -d "=" -f 2)
FFSUB=$(grep "readonly FFSUB" ${BASEDIR}/makeicecat | cut -d "=" -f 2)

VERSION="${MAJOR}.${MINOR}.${FFSUB}"

SRCDIR="${BASEDIR}/output/icecat-${VERSION}"


# Build docker image with

mkdir -p testbuild
docker build testbuild -t mozilla-build:test -f Dockerfile


# The mozconfig is outide of the volume so we copy it first 
# Todo: mount another volume and perform these operation from within the container

#moving to Dockerfile
#cp ${DATADIR}/buildscripts/mozconfig-common ${SRCDIR}/.mozconfig
#cat ${DATADIR}/buildscripts/mozconfig-gnulinux >> ${SRCDIR}/.mozconfig


# Todo:
# Simplify this is basicelly mounting the same directory twice!
# Run with:
docker run -v ${SRCDIR}:/usr/local/src/icecat -v ${BASEDIR}:/usr/local/src/icecat_root -it mozilla-build:test
