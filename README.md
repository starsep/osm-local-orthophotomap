# Description
This project allows to serve local copy of Orthophotomap from Geoportal.
Default settings are for Warsaw.

# Requirements
Make sure you have enough storage.
openssl.conf file is needed to ignore ssl issues with geoportal.gov.pl

# Usage
1. Change variables in Makefile. 
    - You can create output directory (`mkdir output`) or create symlink. (Alternatively change OUTPUT.) 
    - Set up ZOOM. Notice that every extra ZOOM means 4x more tiles. Read more: https://wiki.openstreetmap.org/wiki/Zoom_levels
    - Set up boundaries of orthophotomap. BBOX={south},{west},{north},{east}.
2. `docker run --rm -it -v ./output:/output ghcr.io/starsep/osm-local-orthophotomap:main downloadData` download orthophotomap sheets. For Warsaw 2021 there are 461 files (142 GB).
3. `docker run --rm -it -v ./output:/output ghcr.io/starsep/osm-local-orthophotomap:main generateTiles` for large area with large zoom it can take multiple days.
4. `docker run --rm -it -v ./output:/output -p 127.0.0.1:80:8000 ghcr.io/starsep/osm-local-orthophotomap:main serveTiles` to run Python http server.
5. JOSM tms settings: http://localhost/{zoom}/{x}/{y}.png


docker pull ghcr.io/starsep/osm-local-orthophotomap:main
# Building Docker image
To manually build Docker image use `docker build -t orto .`.
Alternatively use the one built in CI: `ghcr.io/starsep/osm-local-orthophotomap:main`

