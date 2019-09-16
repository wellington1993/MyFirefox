#!/bin/bash

sudo apt install -f -y aptitude coreutils util-linux &>/dev/null
sudo aptitude install -f -y ubuntu-restricted-extras \
  lubuntu-restricted-extras kubuntu-restricted-extras ffmpeg \
  x264 x265 libavformat-dev libavcodec-dev libavdevice-dev \
  libavutil-dev libswscale-dev libswresample-dev libavfilter-dev \
  yasm libass-dev libtheora-dev libvorbis-dev mercurial cmake \
  autoconf automake build-essential git-core libv4l2rds0 \
  libfreetype6-dev libtool libva-dev libvdpau-dev libgl1-mesa-dev \
  libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev libv4l-dev libvpx-dev \
  pkg-config texinfo wget zlib1g-dev libopus-dev libmp3lame-dev \
  git intltool libgtk2.0-dev libspeexdsp-dev libx11-dev libxv-dev \
  libgl1-mesa-dev libreadline-dev libgsm1-dev libsqlite3-dev libupnp-dev \
  libavformat-dev libavdevice-dev frei0r-plugins-dev  frei0r-plugins libgtk2.0-dev libexif-dev \
  libsox-dev libxml2-dev ladspa-sdk libcairo2-dev libswscale-dev qtscript5-dev libqt5svg5-dev \
  libqt5opengl5-dev libepoxy-dev libeigen3-dev libfftw3-dev \
  git  yasm libtool automake   autoconf  libtool-bin  libtheora-bin  libtheora-dev \
  intltool swig libmp3lame-dev libgavl-dev libsamplerate0-dev libsoup2.4-dev   \
  python-dev  libkf5crash-dev  libkf5filemetadata-dev \
  libgavl1 libkf5coreaddons-dev libkf5coreaddons-dev-bin \
  libkf5coreaddons-doc libkf5windowsystem-dev libkf5windowsystem-doc \
  libqt5scripttools5 swig3.0:i386 libprotobuf-dev libleveldb-dev libsnappy-dev \
  libhdf5-serial-dev protobuf-compiler libsrtp-dev open-vm-tools open-vm-tools-dev \
  libmbedtls-dev libmbedtls-doc libmbedtls10 autoconf automake build-essential \
  cmake git libass-dev libbz2-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev \
  libharfbuzz-dev libjansson-dev libjpeg8-dev libtiff5-dev libatlas-base-dev gfortran \
  liblzma-dev libmp3lame-dev libogg-dev libopus-dev libsamplerate-dev \
  libspeex-dev libtheora-dev libtool libtool-bin libvorbis-dev libx264-dev \
  libxml2-dev m4 make nasm patch pkg-config python tar yasm zlib1g-dev \
  libcunit1 libcunit1-dev libantlr3c-dev libantlr3-runtime-java antlr3 \
  libortp-dev libortp9 libmediastreamer-base3 libmediastreamer-dev     \
  extra-cmake-modules libspeex-dev libsrtp0 libupnp6-dev \
  libfdk-aac-dev libvpx-dev libx264-dev lsdvd mplayer gpac zenity \
  mencoder libtwolame-dev libcroco-tools libasound2-dev \
  libavresample-dev libsamplerate-dev libvo-amrwbenc-dev \
  libsndfile-dev  txt2man doxygen libyaml-dev libfftw3-dev python-dev \
  libsamplerate0-dev libtag1-dev libchromaprint-dev python-six &>/dev/null

exit 0
