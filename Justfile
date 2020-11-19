build-all: intio_docker-build intio_gstreamer intio_nginx-rtmp

intio_gstreamer: intio_gstreamer_l4t intio_gstreamer_vanilla

intio_gstreamer_vanilla:
        docker build -t intio/gstreamer gstreamer

intio_gstreamer_l4t:
        docker build -t intio/gstreamer:l4t gstreamer-l4t

intio_docker-build:
        docker build -t intio/docker-build docker-build

intio_nginx-rtmp:
        docker build -t intio/nginx-rtmp nginx-rtmp

push-all:
        docker push intio/docker-build
        docker push intio/gstreamer:l4t
        docker push intio/nginx-rtmp
