#!/bin/bash sudo apt-get install mp3info lame
cd /srv/dev-disk-by-label-DATAGalere/dls/
# constantes FTP
HOST=ftp.radiogalere.org/
LOGIN=***
PASSWORD=***
PORT=21

cp ./file/flux-diff.txt ./now.txt
cp ./logs/$(date +%Y%m%d)-DLS.txt ./today.txt
cp ./logs/$(date +%Y%m%d --date='-1 day')-DLS.txt ./yesterday.txt

curl --user $LOGIN:$PASSWORD --upload-file ./yesterday.txt ftp://$HOST
curl --user $LOGIN:$PASSWORD --upload-file ./today.txt ftp://$HOST
curl --user $LOGIN:$PASSWORD --upload-file ./now.txt ftp://$HOST
