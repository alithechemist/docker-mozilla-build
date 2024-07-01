FROM debian:bookworm
LABEL maintainer="Chippy <chippy@classictetris.net>"
ENV MAINTAINER="chippy@classictetris.net"

CMD ["/bin/bash", "-c", "cp /usr/local/src/icecat_root/data/buildscripts/mozconfig-common .mozconfig  && \
    cat /usr/local/src/icecat_root/data/buildscripts/mozconfig-gnulinux >> .mozconfig && \
    ./mach --no-interactive bootstrap --application-choice browser && \
    ./mach build && \
    ./mach package && \
    MAJOR=$(grep \"readonly FFMAJOR\" /usr/local/src/icecat_root/makeicecat | cut -d \"=\" -f 2) && \
    MINOR=$(grep \"readonly FFMINOR\" /usr/local/src/icecat_root/makeicecat | cut -d \"=\" -f 2) && \
    FFSUB=$(grep \"readonly FFSUB\" /usr/local/src/icecat_root/makeicecat | cut -d \"=\" -f 2) && \
    cd obj-gnulinux && \
    checkinstall -y -D --install=no --pkgname=icecat --pkgversion=${MAJOR}.${MINOR}.${FFSUB}esr --maintainer=${MAINTAINER}  && \
    echo Done;"]

ENV SHELL /bin/bash

ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt update && \
    apt install -y python3 python3-pip clang llvm pkg-config \
    libasound2-dev libpulse-dev cbindgen nodejs libxkbcommon-dev \
    libpango1.0-dev libx11-xcb-dev libxrandr-dev libxcomposite-dev \
    libxcursor-dev libxdamage-dev libxfixes-dev libxi-dev libxtst-dev \
    nasm libgtk-3-dev libdbus-glib-1-dev checkinstall rpm

RUN mkdir -p /usr/local/src/icecat
RUN mkdir -p /usr/local/src/icecat_root

WORKDIR /usr/local/src/icecat
