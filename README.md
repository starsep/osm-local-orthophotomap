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
2. Build docker image `docker build -t orto .`
3. `docker run --rm -it -v ./output:/output orto downloadData` download orthophotomap sheets. For Warsaw 2021 there are 461 files (142 GB).
4. `docker run --rm -it -v ./output:/output orto generateTiles` for large area with large zoom it can take multiple days.
5. `docker run --rm -it -v ./output:/output -p 127.0.0.1:80:8000 orto serveTiles` to run Python http server.
6. JOSM tms settings: http://localhost/{zoom}/{x}/{y}.png
