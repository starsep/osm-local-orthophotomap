#!/usr/bin/env bash

for tile in 19/292570/172211 18/146289/86105 17/73138/43056 16/36570/21524 15/18287/10762; do
    echo $tile
    for FILENAME in cogger gdal0 gdal1 original rio-cogeo; do
        URL="http://192.168.1.50:8000/cog/tiles/$tile?url=%2Fdata%2Fbench%2F$FILENAME.tif"
        SIZE=$(http -h "$URL" | rg content-length | sd "content-length: " "" | sd "\r" "" | numfmt --from=si --to=iec --format="%.2f" --suffix=B)
        AVERAGE=$(hey -n 10 -c 1 "$URL" | rg Average | sd "\W*Average\W*:\W*" "" | sd " secs" "s")
        echo "$FILENAME: $AVERAGE ($SIZE)"
    done
done
