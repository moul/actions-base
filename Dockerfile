# dynamic config
ARG             BUILD_DATE
ARG             VCS_REF
ARG             VERSION

# build
FROM            golang:1.17.8-alpine as builder
RUN             apk add --no-cache git gcc musl-dev make
ENV             GO111MODULE=on
RUN             go get -u \
                  golang.org/x/tools/cmd/goimports


# minimalist runtime
FROM alpine:3.15.0
LABEL           org.label-schema.build-date=$BUILD_DATE \
                org.label-schema.name="actions-base" \
                org.label-schema.description="" \
                org.label-schema.url="https://moul.io/actions-base/" \
                org.label-schema.vcs-ref=$VCS_REF \
                org.label-schema.vcs-url="https://github.com/moul/actions-base" \
                org.label-schema.vendor="Manfred Touron" \
                org.label-schema.version=$VERSION \
                org.label-schema.schema-version="1.0" \
                org.label-schema.cmd="docker run -i -t --rm moul/actions-base" \
                org.label-schema.help="docker exec -it $CONTAINER actions-base --help"
RUN             apk add --no-cache jq curl
COPY            --from=builder /go/bin/goimports /bin/
ENTRYPOINT      ["/bin/actions-base"]
#CMD             []
