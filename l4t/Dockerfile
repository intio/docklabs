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

# Upgrade to r32.5 (base image not ready as of 2021-01-26)
RUN  apt-get update -q \
        && DEBIAN_FRONTEND=noninteractive \
        apt-get dist-upgrade -qy \
    && rm -rf /var/lib/apt/lists/*

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
