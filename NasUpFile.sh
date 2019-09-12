#!/bin/bash sudo apt-get install mp3info lame
cd /srv/dev-disk-by-label-DATAGalere/uptoradiogalereorg/
# constantes FTP
HOST=ftp.radiogalere.org/upauto/
LOGINFTP=*****
PASSWORDFTP=****
LOGINSSH=*****
PASSWORDSSH=****
PORT=21

chmod 744 ./FichiersAConvertir/*
#MP3
for i in FichiersAConvertir/*.mp3; do
   	j="${i%.mp3}"
	j="${j##FichiersAConvertir/}"

	c="${j// /}"
	c=$(echo $c | iconv -f utf8 -t ascii//TRANSLIT)

	filedate=$(date -r "FichiersAConvertir/$j.mp3" '+%Y-%m-%d') #connaite la date de modification

	bit=$(mp3info -p %r "FichiersAConvertir/$j.mp3")

	if [ "$bit" -ge 128 ]
	then
	echo "c'est NOK $i est en $bit"
        lame -b 192 "FichiersAConvertir/$j.mp3" "tmp/$filedate-$c.mp3"
	rm "FichiersAConvertir/$j.mp3"
        else
	echo "c'est OK $i est en $bit"
	mv "FichiersAConvertir/$j.mp3" "tmp/$filedate-$c.mp3"
	fi
echo "mv $i to tmp"

done

#WAV
for i in FichiersAConvertir/*.wav; do
	j="${i%.wav}"
	j="${j##FichiersAConvertir/}"

	c=${j// /}
        c=$(echo $c | iconv -f utf8 -t ascii//TRANSLIT)

	filedate=$(date -r "FichiersAConvertir/$j.wav" '+%Y-%m-%d')

        #echo "mv $i to tmp"
        lame -b 128 "FichiersAConvertir/$j.wav" "tmp/$filedate-$c.mp3"
	rm "FichiersAConvertir/$j.wav"
done
chmod 766 ./FichiersAConvertir/*
# up serveur

for i in tmp/*.*; do
        j="${i##tmp/}"
	#sshpass -p "$PASSWORDSSH" scp "tmp/$j" $LOGINSSH@radiogalere.org:/var/www/clients/client1/web1/web/sidiimportela/
	curl --user $LOGINFTP:$PASSWORDFTP --upload-file ./tmp/$j ftp://$HOST
 	mv ./tmp/$j ./done/$j
done

#rm old file

datefileold=$(date +%Y-%m-%d --date='-15 day')
rm ./done/$datefileold-*
