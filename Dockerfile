FROM node:lts-alpine

WORKDIR /usr/src/api

RUN echo "unsafe-perm = true" >> ~/.npmrc

# Installing Strapi
RUN npm install -g strapi

# Installing nginx
RUN  apk add nginx
RUN mkdir -p /etc/nginx/certs

# Copying the certificates and nginx config
COPY domain.crt  /etc/nginx/certs/domain.crt
COPY domain.key  /etc/nginx/certs/domain.key
COPY nginx.conf /etc/nginx/nginx.conf

# Moving the start-up script to the appropriate location
COPY strapi.sh /root

# Giving read and execution permissions
RUN chmod +x /root/strapi.sh

WORKDIR /etc/init.d/

RUN mkdir -p /run/nginx
EXPOSE 1337

ENTRYPOINT [ "/root/strapi.sh" ]