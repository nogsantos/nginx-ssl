FROM nginx

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    && openssl \
    && rm -rf /var/lib/apt/lists/* \
    && openssl dhparam -out /etc/ssl/certs/dhparam.pem 1024 \
    && openssl req -nodes -new -newkey rsa:4096 -out server.csr -sha256 -subj "/C=CL/ST=Nogsantos/L=Nogsantos/O=MyApp/OU=IT Department/CN=localhost" \
    && mv privkey.pem /etc/ssl/private/server.key \
    && openssl x509 -req -days 365 -sha256 -in server.csr -signkey /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

COPY default.conf /etc/nginx/conf.d/default.conf
