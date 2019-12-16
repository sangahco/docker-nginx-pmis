#!/bin/sh

set -e

export SSL=${SSL_ENABLED:?missing}

echo "Starting HTTP server with the following settings:"
echo "- ssl enabled:     ${SSL_ENABLED}"

if [ "$SSL_ENABLED" == "1" ] && [ -f '/usr/share/nginx/conf.d/ssl.conf.bak' ]; then
    mv /usr/share/nginx/conf.d/ssl.conf.bak /usr/share/nginx/conf.d/ssl.conf
    sed -i 's/listen 80/listen 443 ssl http2/' /usr/share/nginx/conf.d/pmis.conf
    sed -i 's/#ssl_/ssl_/' /usr/share/nginx/conf.d/pmis.conf
    sed -i 's/#proxy_set_header/proxy_set_header/' /usr/share/nginx/conf.d/pmis-proxy.include
fi

if [ "$NAMESERVERS" == "" ]; then
    export NAMESERVERS=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | tr '\n' ' ')
fi

envsubst '$NAMESERVERS' < /etc/nginx/nginx.template.conf > /etc/nginx/nginx.conf

exec nginx -g "daemon off;" "$@"