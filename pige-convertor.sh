#!/bin/bash

cd /media/f710cfd2-00b3-4c36-888e-a6e9e352a5d7/pige/

daylast=$(date '+%Y/%m-%d' -d 'last month')

#MP3
for i in "$daylast/*.ogg"; do
        j="${i%.ogg}"
        j="${j##$daylast/}"
echo "$j"
        lame -b 192 "$daylast/$j.ogg" "$daylast/$j.mp3"
#        rm "FichiersAConvertir/$j.mp3"

echo "$i is OK"

done

echo "$daylast is OK"

