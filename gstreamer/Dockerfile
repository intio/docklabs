ARG BASE=ubuntu:bionic
FROM $BASE
RUN set -eux; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update; \
  apt-get dist-upgrade -qy; \
  apt-get install -qy --no-install-recommends \
  curl ca-certificates \
  gir1.2-gstreamer-1.0 \
  gstreamer1.0-alsa \
  gstreamer1.0-gl \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-base-apps \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-pulseaudio \
  gstreamer1.0-tools \
  gstreamer1.0-x \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer1.0-dev \
  mesa-va-drivers \
  mesa-vdpau-drivers \
  ; \
  rm -rf /var/lib/apt/lists/* ; \
  gst-inspect-1.0 --version; \
  rm -rf /root/.cache
