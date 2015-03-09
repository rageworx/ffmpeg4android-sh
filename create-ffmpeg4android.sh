#!/bin/bash

DEST_TARGET=""
OPT_DEST=0

if [ "$1" != "" ]; then
	DEST_TARGET="$1"
	DEST_TEST="releases/$DEST_TARGET"
	OPT_DEST=1

	if [ ! -e $DEST_TEST ]; then
		OPT_DEST=0
	fi
fi

for ffmpegdir in `find ffmpeg* -maxdepth 0 -type d | sort -rV`
do
    rm -rf $ffmpegdir
done

for tarfile in `find releases/ffmpeg* | sort -rV`
do
    tar -xf $tarfile
done

RELEASE_TIMESTAMP=`date +%Y%m%d%H%M`

if [ $OPT_DEST -eq 1 ]; then
	$ffmpegdir=$DEST_TEST

	touch -t $RELEASE_TIMESTAMP ./ffmpeg4android.readme
	cp ./ffmpeg4android.readme $ffmpegdir.android/

	for makefile in `find makefiles/* | grep .mk`
	do
	    touch -t $RELEASE_TIMESTAMP $makefile
	    cp $makefile ${makefile/#makefiles/$ffmpegdir.android}
	done
else
	for ffmpegdir in `find ffmpeg* -maxdepth 0 -type d | sort -rV`
	do
		mv $ffmpegdir $ffmpegdir.android

		touch -t $RELEASE_TIMESTAMP ./ffmpeg4android.readme
		cp ./ffmpeg4android.readme $ffmpegdir.android/

		for makefile in `find makefiles/* | grep .mk`
		do
		    touch -t $RELEASE_TIMESTAMP $makefile
		    cp $makefile ${makefile/#makefiles/$ffmpegdir.android}
		done
	done
fi

rm -rf releases.android
mkdir releases.android

for ffmpegdir in `find ffmpeg*.android -maxdepth 0 -type d | sort -rV`
do
    tar czf releases.android/$ffmpegdir.tar.gz $ffmpegdir &
done

for ffmpegdir in `find ffmpeg*.android -maxdepth 0 -type d | sort -rV`
do
    touch -t $RELEASE_TIMESTAMP releases.android/$ffmpegdir.tar.gz
done
