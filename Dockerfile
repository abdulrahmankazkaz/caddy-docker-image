FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-ratelimit 

FROM caddy:alpine


COPY --from=builder /usr/bin/caddy /usr/bin/caddy


RUN addgroup -g 1000 -S caddy \
    && adduser  -u 1000 -G caddy -S -s /sbin/nologin -H caddy \
    && install -d -o caddy -g caddy -m 0750 /data \
    && install -d -o caddy -g caddy -m 0750 /config

USER caddy

