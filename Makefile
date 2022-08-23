BBOX=52,20.7,52.4,21.4
YEAR=2021
OUTPUT=/media/starsep/OSM/Orto2021
ORTHOMAP_ID=75063
ZOOMS=12-15
JOBS=24

downloadData: ortoUrls
	cat ortoUrls | parallel -j ${JOBS} OPENSSL_CONF=openssl.conf wget -P ${OUTPUT} {}

ortoUrls:
	http GET 'http://mapy.geoportal.gov.pl/wss/service/PZGIK/ORTO/WFS/Skorowidze?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=gugik:SkorowidzOrtofomapy${YEAR}&TYPENAME=gugik:SkorowidzOrtofomapy${YEAR}&SRSNAME=urn:ogc:def:crs:EPSG::4326&BBOX=${BBOX},urn:ogc:def:crs:EPSG::4326' | rg ${ORTHOMAP_ID} | sed -e "s/.*https/https/" -e "s/tif.*/tif/" | sort > ortoUrls

mergeTiff:
	cd ${OUTPUT}
	gdalbuildvrt merged.vrt *.tif 

generateTiles:
	cd ${OUTPUT}
	gdal2tiles.py --zoom=${ZOOMS} --processes=${JOBS} merged.vrt output
