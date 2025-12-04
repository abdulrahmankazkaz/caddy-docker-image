FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-ratelimit 

FROM caddy:alpine

ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data \
    TZ=Asia/Baghdad

RUN addgroup -S caddy && adduser -S -G caddy caddy \
    && mkdir -p /config /data \
    && chown -R caddy:caddy /config /data

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

USER caddy

