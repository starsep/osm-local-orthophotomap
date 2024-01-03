#!/usr/bin/env bash

for fmt in png npy tif jpg jp2 webp pngraw; do
	URL="http://192.168.1.50:8000/mosaicjson/tiles/16/36580/21587.$fmt?url=%2Fdata%2Fwaw2023.json"
    SIZE=$(http -h "$URL" | rg content-length | sd "content-length: " "" | sd "\r" "" | numfmt --from=si --to=iec --format="%.2f" --suffix=B)
    AVERAGE=$(hey -n 10 -c 1 "$URL" | rg Average | sd "\W*Average\W*:\W*" "" | sd " secs" "s")
    echo "$fmt: $AVERAGE ($SIZE)"
done
