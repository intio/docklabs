# Docklabs

We're [INTIO TV](https://www.intio.tv/), and we use Docker to run
things. Some of our Docker things are public on
[DockerHub](https://hub.docker.com/u/intio) and on
[Github](https://github.com/intio/docklabs).

## Builder image

This is `intio/docker-build`, a builder image, that can be used with
CI services (like [CircleCI][]) to build other Docker images
([docker-out-of-docker][]). It has Docker Compose and git installed.

[CircleCI]: https://circleci.com
[docker-out-of-docker]: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

Minimal configuration for CircleCI (build only):

```yaml
version: 2.1

workflows:
  main:
    jobs:
    - build

jobs:
  build:
    docker:
    - image: intio/docker-build
      auth:
        username: $DOCKERHUB_USERNAME
        password: $DOCKERHUB_PASSWORD
    steps:
    - checkout
    - setup_remote_docker:
        docker_layer_caching: false
    - run:
        name: Build images
        command: docker-compose build

```

## GStreamer

There are flavors for regular systems (`intio/gstreamer:latest`) and
for Tegra-based ARM64 boards (like NVidia Jetson; `intio/gstreamer:l4t`).

In both cases, the base OS is Ubuntu 18.04 (Bionic Beaver), with
GStreamer 1.14, since this is what NVidia supports.

If you want to access the CSI camera on an l4t board, you need to run
`nvargus-daemon`. You can either run it as a background process in an
interactive session, or (**TODO**) use the included `runit`
integration to have it run supervised in a dev/prod workload.

## Nginx with RTMP module

Dockerized nginx with [RTMP module][].

Configured with:

- basic live in/out,
- basic stats dashboard,

and without any: recording, transcoding, re-streaming, or
authentication - use on LANs only.

[RTMP module]: https://github.com/arut/nginx-rtmp-module
