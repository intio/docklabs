FROM nvcr.io/nvidia/l4t-base:r32.4.4

# Upgrade the base image; install ca-certificates for HTTPS repos.
RUN  apt-get update -q \
        && DEBIAN_FRONTEND=noninteractive \
        apt-get dist-upgrade -qy \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get install -qy --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# NVidia's proprietary l4t packages
ADD ./jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc
ADD ./nvidia-l4t-apt-source.list /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

# NVidia's packages verify that the required hardware is present
# during the installation. Docker does not currently allow mapping a
# host filesystem into the build container; we also may want to build
# on a foreign system like Raspberry Pi or Qemu. Disable this check.
RUN mkdir -p /opt/nvidia/l4t-packages \
        && touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall

# Workaround: the file nvidia-tegra.conf already exists in the base
# system, but nvidia-l4t-core wants to overwrite it, making dpkg barf.
#
# We want to allow dpkg to proceed noninteractively here (which it
# won't, even with -qy and DEBIAN_FRONTEND=noninteractive), but we
# also want the correct contents of this file (which nvidia-l4t-core
# breaks, by replacing its contents with a *nonexistent* path), so we
# also give it a different name.
#
# Since we're dealing with the dynamic linker, it's prudent to run
# ldconfig. Since this will affect GStreamer, a common issue is that
# due to missing .so's some plugins may fail to load on first try and
# the list of (un)available elements will remain cached.
RUN rm /etc/ld.so.conf.d/nvidia-tegra.conf \
        && { \
        echo /usr/lib/aarch64-linux-gnu/tegra; \
        echo /usr/lib/aarch64-linux-gnu/tegra-egl; \
        }> /etc/ld.so.conf.d/tegra.conf \
        && ldconfig \
        && rm -rf /root/.cache ~/.cache

# Install some common tools, runit, GStreamer, l4t.
RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy --no-install-recommends \
        curl ca-certificates \
        less \
        mg vim-tiny net-tools procps \
        runit \
        gir1.2-gstreamer-1.0 \
        gir1.2-gst-rtsp-server-1.0 \
        gstreamer1.0-alsa \
        gstreamer1.0-gl \
        gstreamer1.0-libav \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-base-apps \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-pulseaudio \
        gstreamer1.0-rtsp \
        gstreamer1.0-tools \
        gstreamer1.0-x \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer1.0-dev \
        libgirepository1.0-dev \
        mesa-va-drivers \
        mesa-vdpau-drivers \
        nvidia-l4t-camera \
        nvidia-l4t-gstreamer \
        nvidia-l4t-multimedia-utils \
    && rm -rf /var/lib/apt/lists/*

# Set up runit - we need it for things like nvargus-daemon.
ADD ./entrypoint /bin/entrypoint
ENTRYPOINT ["/bin/entrypoint"]
CMD ["/usr/bin/runsvdir", "-P", "/etc/service"]
