FROM alpine:3.8

ENV HOME_DIR=/opt/crontab
RUN apk add --no-cache --virtual .run-deps bash jq \
    && mkdir -p ${HOME_DIR}/jobs ${HOME_DIR}/projects \
    && adduser -S docker -D

COPY docker-entrypoint /
ENTRYPOINT ["/docker-entrypoint"]

HEALTHCHECK --interval=5s --timeout=3s \
    CMD ps aux | grep '[c]rond' || exit 1

CMD ["crond","-f"]
