FROM debian:stable-slim

LABEL version="1.0" \
      maintainer="william@hyp5r.io"

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    wget && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /usr/local/ezproxy && \
  mkdir /usr/local/ezproxy/config && \
  wget -O /usr/local/ezproxy/ezproxy https://help.oclc.org/@api/deki/files/9850/ezproxy-linux.bin && \
  chmod +x /usr/local/ezproxy/ezproxy && \
  /usr/local/ezproxy/ezproxy -d /usr/local/ezproxy/config -m; exit 0 && \
  apt-get purge -y \
    wget && \
  apt-get clean && \
  apt-get autoremove -y

ENV EZPROXY_WSKEY=

VOLUME /usr/local/ezproxy/config
EXPOSE 2048

COPY docker-entrypoint.sh /usr/local/ezproxy
ENTRYPOINT ["/usr/local/ezproxy/docker-entrypoint.sh"]