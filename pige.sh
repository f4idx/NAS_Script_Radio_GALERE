#!/bin/bash

cd /srv/dev-disk-by-label-DATAGalere/pige/

heurein=$(date '+%H%M%S')
year=$(date '+%Y')
day=$(date '+%m-%d')
mkdir "$year"
mkdir "$year/$day"

ffmpeg -i "http://radiogalere.org:8080/galere.mp3" -t 01:00:00 -ab 128k -f mp3 "temp$heurein.mp3"

heureout=$(date '+%H%M%S')

mv "temp$heurein.mp3" "$year/$day/Pige_$day_$heurein-$heureout.mp3"
echo "Pige_$day_$heurein-$heureout.mp3"

