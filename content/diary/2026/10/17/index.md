---
title: 2026-10-17 TIFF 压缩
date: 2026-10-17T21:37:05+08:00
lastmod: 2026-10-19T11:21:44+08:00
comments: true
---

<!--more-->

```bash
#!/usr/bin/env bash

mkdir -p compressed

for f in *.tif *.tiff; do
    [[ -f "$f" ]] || continue
    # tiffcp -c lzw "$f" "compressed/LZD_$f" # LZW
    # tiffcp -c zip "$f" "compressed/ZIP_$f" # Deflate
    mkdir -p compressed/JPEG_tmp
    magick "$f" -depth 8 "compressed/JPEG_tmp/8BIT_$f" # JPEG only works for 8-bit images
    tiffcp -r 8 -c jpeg:r:30 "compressed/JPEG_tmp/8BIT_$f" "compressed/JPEG_$f"
done

rm -r compressed/JPEG_tmp
```
