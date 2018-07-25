FROM sangah/nginx-base

COPY . /usr/local/src/

ARG SYSCONF=1.0.1
ADD https://github.com/sangahco/pmis-system-config/releases/download/v${SYSCONF}/sysconf-v${SYSCONF}.tar.gz sysconf.tar.bz2
RUN set -x && \
    tar -xf sysconf.tar.bz2 && \
    mkdir -p /usr/local/share/sysconf && \
    cp -a sysconf*/. /usr/local/share/sysconf/

RUN cp /usr/local/src/docker-entrypoint.sh /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    rm -rf /usr/local/src

ENV SSL_ENABLED=0

#HEALTHCHECK --interval=60s CMD curl --fail http://127.0.0.1/ || exit 1