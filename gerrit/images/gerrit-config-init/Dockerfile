FROM alpine:3.8

RUN apk add --no-cache curl git

COPY gerrit-config-init.sh /gerrit-config-init.sh

ENTRYPOINT ["/gerrit-config-init.sh"]
