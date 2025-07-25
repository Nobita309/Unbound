FROM alpine:latest

RUN apk add --no-cache unbound wget perl \
  && mkdir -p /var/lib/unbound \
  && chown -R unbound:unbound /var/lib/unbound

RUN wget -qO /etc/unbound/root.hints https://www.internic.net/domain/named.cache \
  && unbound-anchor -a /var/lib/unbound/root.key || true

COPY unbound.sh /unbound.sh
RUN sed -i 's/\r//g' /unbound.sh && \
    chmod +x /unbound.sh

CMD ["/bin/sh", "/unbound.sh"]
