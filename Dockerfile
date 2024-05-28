FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

RUN apt-get update && apt-get install -y \
    bash \
    make \
    parallel \
    httpie \
    gdal-bin \
    python3-gdal \
    wget \
    time \
    && rm -rf /var/lib/apt/lists/*

COPY Makefile openssl.conf README.md ./

ENTRYPOINT ["make"]
