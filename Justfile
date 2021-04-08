build-all: intio_docker-build intio_l4t intio_gstreamer intio_nginx-rtmp

l4t_version := "r32.5"

intio_l4t: intio_l4t_t194 intio_l4t_t210
intio_l4t_t194:
        docker build --build-arg BOARD=t194 -t intio/l4t:{{l4t_version}}-t194 l4t

intio_l4t_t210:
        docker build --build-arg BOARD=t210 -t intio/l4t:{{l4t_version}}-t210 l4t

intio_gstreamer: intio_gstreamer_l4t_t194 intio_gstreamer_l4t_t210 intio_gstreamer_vanilla

intio_gstreamer_vanilla:
        docker build -t intio/gstreamer gstreamer

intio_gstreamer_l4t_t194: intio_l4t_t194
        docker build \
                --build-arg BOARD=t194 \
                -t intio/gstreamer:l4t-{{l4t_version}}-t194 \
                gstreamer-l4t

intio_gstreamer_l4t_t210: intio_l4t_t210
        docker build \
                --build-arg BOARD=t210 \
                -t intio/gstreamer:l4t-{{l4t_version}}-t210 \
                gstreamer-l4t

intio_docker-build:
        docker build -t intio/docker-build docker-build

intio_nginx-rtmp:
        docker build -t intio/nginx-rtmp nginx-rtmp

push-all:
        docker push intio/docker-build
        docker push intio/gstreamer:l4t-{{l4t_version}}-t194
        docker push intio/gstreamer:l4t-{{l4t_version}}-t210
        docker push intio/gstreamer:latest
        docker push intio/l4t:{{l4t_version}}-t194
        docker push intio/l4t:{{l4t_version}}-t210
        docker push intio/nginx-rtmp
