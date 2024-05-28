FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

RUN apt-get update && apt-get install --no-install-recommends -y \
    bash \
    make \
    parallel \
    httpie \
    gdal-bin \
    python3-gdal \
    wget \
    time \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY Makefile openssl.conf README.md ./

ENTRYPOINT ["make"]
