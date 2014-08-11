#!/bin/bash

for f in *.png
do
    convert $f -thumbnail 400x400^ -gravity center -extent 400x400 $(basename $f .png)_thumb.png
done
