FROM alpine:3.17

RUN apk upgrade --no-cache && \
    apk add --no-cache curl ca-certificates vim tini openssh && \
    mkdir -p /opt/frp && cd /opt/frp && \
    curl -sSL -o frp.tar.gz "https://github.com/fatedier/frp/releases/download/v0.47.0/frp_0.47.0_linux_amd64.tar.gz" && \
    tar -xf frp.tar.gz --strip-components 1 && \
    mv -f frps /usr/local/bin/frps && \
    cd / && rm -rf /opt/frp

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD ["/usr/local/bin/frps", "-c", "/etc/frps.ini"]