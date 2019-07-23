FROM docker:stable

ARG DOCKER_COMPOSE_VERSION=1.24.1

RUN apk add --no-cache \
  git \
  openssh-client \
  python-dev \
  py2-pip \
  libffi-dev \
  openssl-dev \
  gcc \
  libc-dev \
  make \
  && pip install docker-compose==${DOCKER_COMPOSE_VERSION}
