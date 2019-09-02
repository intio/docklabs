FROM nginx:stable-alpine
RUN apk --no-cache add apache2-utils
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080 8443
ENV USER= PASSWORD=
