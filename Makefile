BBOX=52,20.7,52.4,21.4
YEAR=2023
ORTHOMAP_ID=78049
ZOOMS=1-18
JOBS=24
OUTPUT=output

downloadData: ortoUrls
	cat ortoUrls | parallel -j ${JOBS} OPENSSL_CONF=openssl.conf wget -P ${OUTPUT} {}

ortoUrls:
	http GET 'http://mapy.geoportal.gov.pl/wss/service/PZGIK/ORTO/WFS/Skorowidze?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=gugik:SkorowidzOrtofomapy${YEAR}&TYPENAME=gugik:SkorowidzOrtofomapy${YEAR}&SRSNAME=urn:ogc:def:crs:EPSG::4326&BBOX=${BBOX},urn:ogc:def:crs:EPSG::4326' | grep "${ORTHOMAP_ID}" | sed -e "s/.*https/https/" -e "s/tif.*/tif/" | sort > ortoUrls

${OUTPUT}/merged.vrt:
	gdalbuildvrt ${OUTPUT}/merged.vrt ${OUTPUT}/*.tif

generateTiles: ${OUTPUT}/merged.vrt
	mkdir -p ${OUTPUT}/tiles
	rm -f ${OUTPUT}/tiles/leaflet.html
	time gdal2tiles.py --zoom=${ZOOMS} --processes=${JOBS} --webviewer=leaflet --xyz --resume ${OUTPUT}/merged.vrt ${OUTPUT}/tiles

serveTiles:
	python3 -m http.server --directory ${OUTPUT}/tiles
