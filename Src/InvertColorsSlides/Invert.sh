#!/usr/bin/env bash

#Do everything in a temporary directory and don't harm orignal file
mkdir tmp_inverted
cp $1 tmp_inverted/
cd tmp_inverted/
## Use imagemagick to negate and into grayscale.
convert $1 -negate -colorspace Gray tmp.jpg
## Everything back together as a pdf
convert *jpg tmp.pdf
## Export one directory higher
basename=$(echo "$1" | cut -f 1 -d '.')
cp tmp.pdf ../${basename}_Inverted.pdf
## Cleanup
cd ..
rm -fr tmp_inverted/
