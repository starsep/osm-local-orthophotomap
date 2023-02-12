FROM alpine:latest
RUN apk add bash make parallel httpie gdal gdal-tools
COPY Makefile openssl.conf README.md ./
ENTRYPOINT ["make"]
