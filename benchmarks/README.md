Benchmarks
1. Original file. Format. One tile, 10 request sequentially. Average time (code format.sh)

npy: 0.3794s (155KB)
tif: 0.3990s (150KB)
jpeg: 0.4066s (20KB)
jp2: 0.4192s (61KB)
pngraw: 0.4265s (129KB)
png: 0.4412s (124KB)
webp: 0.4538s (12KB)

2. Converting
File used: waw2023/78049_1196552_N-34-126-D-d-1-1.tif

> du -b *.tif | numfmt --from=si --to=iec --format="%.2f" 
1,07G cogger.tif
1017,57M gdal0.tif
5,35G gdal1.tif
1,06G original.tif
5,93G rio-cogeo.tif

a) Cogger v0.0.7
`cogger -output cogger.tif original.tif`

b) rio-cogeo 5.1.0
`rio cogeo create original.tif rio-cogeo.tif -w --use-cog-driver`

c) gdal (GDAL 3.8.2, released 2023/16/12)

`gdal_translate original.tif gdal0.tif -of COG -co RESAMPLING=LANCZOS -co COMPRESS=JPEG -co QUALITY=95 -co BIGTIFF=YES -co NUM_THREADS=8 -co TARGET_SRS=EPSG:4326`

cogger: 0.1799s (18,85KB)
gdal0: 0.0600s (24,20KB)
gdal1: 0.0814s (29,72KB)
original: 0.2183s (18,85KB)
rio-cogeo: 0.0300s (29,97KB)


d) gdal (GDAL 3.4.1, released 2021/12/27) + cogger according to https://github.com/airbusgeo/cogger#with-internal-overviews
```
gdal_translate -of GTIFF -co BIGTIFF=YES -co TILED=YES -co COMPRESS=ZSTD -co NUM_THREADS=4 original.tif gdal1tmp.tif
gdaladdo --config GDAL_NUM_THREADS 4 --config COMPRESS_OVERVIEW ZSTD gdal1tmp.tif 2 4 8 16 32
cogger -output gdal1.tif gdal1tmp.tif
```
