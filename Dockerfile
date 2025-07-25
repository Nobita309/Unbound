FROM alpine:latest

RUN apk add --no-cache unbound wget \
  && mkdir -p /var/lib/unbound \
  && chown -R unbound:unbound /var/lib/unbound

RUN wget -qO /etc/unbound/root.hints https://www.internic.net/domain/named.cache \
  && unbound-anchor -a /var/lib/unbound/root.key || true

COPY ./unbound.sh /etc/unbound

RUN chmod +x /etc/unbound/unbound.sh

CMD ["/unbound.sh"]
