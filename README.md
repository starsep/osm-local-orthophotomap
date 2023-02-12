# Description
This project allows to serve local copy of Orthophotomap from Geoportal.
Default settings are for Warsaw.

# Requirements
Requires GDAL.
Make sure you have enough storage.
openssl.conf file is needed to ignore ssl issues with geoportal.gov.pl

# Usage
1. Change variables in Makefile. You can create output directory or create symlink. Alternatively change OUTPUT. Notice that every extra ZOOM means 4x more tiles. Read more: https://wiki.openstreetmap.org/wiki/Zoom_levels
2. `make downloadData` download orthophotomap sheets. For Warsaw 2021 there are 461 files (142 GB).
3. `make generateTiles` for large area with large zoom it can take multiple days.
4. `make serveTiles` to run Python http server.
5. JOSM tms settings: http://localhost:8000/{zoom}/{x}/{y}.png

# Docker
Change path to output volume.
```
docker build -t orto .
docker run --rm -it -v /volume1/OSM/Orto2022:/output orto
```
