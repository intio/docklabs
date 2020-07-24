FROM debian:buster-slim
RUN set -eux; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update -q; \
  apt-get dist-upgrade -qy; \
  apt-get install -qy --no-install-recommends nginx-light libnginx-mod-rtmp; \
  rm -rf /var/lib/apt/lists/*; \
  rm -f /var/www/html/index.nginx-debian.html; \
  nginx -V

COPY nginx.conf /etc/nginx/nginx.conf
COPY stat.xsl /var/www/html/stat.xsl
EXPOSE 80 443 1935

CMD ["nginx"]
