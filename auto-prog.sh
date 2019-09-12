#!/bin/bash
#sudo apt-get install smbclient
dossierlocal="/srv/dev-disk-by-label-DATAGalere/auto-prog/"
date=$(date '+%Y-%m-%d-%H')
reseauURL="//PROG-MUSICALE/Emission"

cd "$dossierlocal/"

for i in $date-*.wav; do
   	echo "Go to $i"
	j="${i##$date-}"
	mv "$date-$j" "up/$j"
	cd "$dossierlocal/up"
	sudo smbclient -N $reseauURL -c" prompt; recurse; mput *; exit"
	cd "$dossierlocal/"
	mv "./up/$j" "./done/$date-done-$j"
	echo "$j is done"

done
