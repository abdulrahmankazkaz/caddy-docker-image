FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-ratelimit 

FROM caddy:alpine


RUN addgroup -S caddy && adduser -S -G caddy caddy \
    && mkdir -p /config/caddy \
    && mkdir -p /data/caddy \
    && chown -R caddy:caddy /config /data

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

USER caddy

