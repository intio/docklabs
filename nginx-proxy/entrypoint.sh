#!/bin/sh
set -eu
htpasswd -nb "$USER" "$PASSWORD" > /etc/nginx/htpasswd
exec "$@"
