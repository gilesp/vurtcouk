#!/bin/bash

if [ -z "$1" ]
then
    echo "Must specify image to convert to header"
    exit -1
fi

convert $1 -gravity Center -crop 900x300+0+0 +repage -modulate 100,0 $(basename $1 .png)_header.png
