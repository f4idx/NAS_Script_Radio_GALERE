#!/bin/bash
#sudo apt-get install mp3info ffmpg
cd /media/joachim-galere/DATA-HOME/SITE_sup/
mkdir mp3aconvertir/

#MP3
for i in FichiersAConvertir/*.mp3; do
   j="${i%.mp3}"
   filedate=$(date -r convertor.sh '+%Y/%m/%d')
   bit=$(mp3info -p %r "$j.mp3")

	if [ "$bit" -ge 129 ]
	then
	echo "c'est NOK $i est en $bit"
        ffmpeg -i "FichiersAConvertir/$j.mp3" -codec:a libmp3lame -b:a 128k "tmp/$filedate$j.mp3"

        else
	echo "c'est OK $i est en $bit"
	mv "FichiersAConvertir/$j.mp3" "tmp/$filedate$j.mp3"
	fi
echo "mv $i to tmp"

done

#WAV
for i in FichiersAConvertir/*.wav; do
   j="${i%.mp3}"
   filedate=$(date -r convertor.sh '+%Y/%m/%d')

        echo "mv $i to tmp"
        ffmpeg -i "FichiersAConvertir/$j.wav" -codec:a libmp3lame -b:a 128k "tmp/$filedate$j.mp3"
done

