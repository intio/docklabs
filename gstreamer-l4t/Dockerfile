FROM intio/l4t:r32.4.4

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
