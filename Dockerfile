FROM alpine:3.11

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories ;\
    apk add pptpclient ppp dnsmasq miniupnpd ;\
    rm -rf /etc/dnsmasq.conf /etc/miniupnpd

COPY root/ /

HEALTHCHECK --interval=60s --timeout=5s CMD ifconfig ppp0 || exit 1

ENTRYPOINT ["/startup.sh"]
