#!/bin/bash
#Script changed by 

TEST_PATH="${PWD}/releases"

OPT_SUPPORTED=0
OPT_VER22=0
OPT_VER21=0
OPT_VER112=0
OPT_VER104=0
OPT_VER0112=0
OPT_VER0106=0
OPT_VER092=0
OPT_VER0812=0
OPT_VER0714=0

SUPPORTED_VERSIONS="2.2, 2.1, 1.1.2, 1.0.4, 0.11.2, 0.10.6, 0.9.2, 0.8.12, 0.7.14"

if [ "$1" == "" ]; then
	echo ""
	echo " $0 (option or version)"
	echo ""
	echo " _options_ "
	echo "      clean : delete all sub folders."
	echo "      all   : recieve all supported versions."
	echo ""
	echo " _supported versions_"
	echo "      $SUPPORTED_VERSIONS"
	echo ""
	exit 0
fi

if [ "$1" == "all" ]; then
	OPT_VER22=1
	OPT_VER21=1
	OPT_VER112=1
	OPT_VER104=1
	OPT_VER0112=1
	OPT_VER0106=1
	OPT_VER092=1
	OPT_VER0812=1
	OPT_VER0714=1
	OPT_SUPPORTED=1
elif [ "$1" == "clean" ]; then
	echo "Cleanning all sub directories ..."
	rm -rf release
	rm -rf ffmpeg*
	rm -rf test*
	echo "Done."
	exit 0
else
	if [ "$1" == "2.2" ]; then
		OPT_VER22=1
		OPT_SUPPORTED=1
	elif [ "$1" == "2.1" ]; then
		OPT_VER21=1
		OPT_SUPPORTED=1
	elif [ "$1" == "1.1.2" ]; then
		OPT_VER112=1
		OPT_SUPPORTED=1
	elif [ "$1" == "1.0.4" ]; then
		OPT_VER104=1
		OPT_SUPPORTED=1
	elif [ "$1" == "0.11.2" ]; then
		OPT_VER0112=1
		OPT_SUPPORTED=1
	elif [ "$1" == "0.10.6" ]; then
		OPT_VER0106=1
		OPT_SUPPORTED=1
	elif [ "$1" == "0.9.2" ]; then
		OPT_VER092=1
		OPT_SUPPORTED=1
	elif [ "$1" == "0.8.12" ]; then
		OPT_VER0812=1
		OPT_SUPPORTED=1
	elif [ "$1" == "0.7.14" ]; then
		OPT_VER0714=1
		OPT_SUPPORTED=1
	fi
fi

if [ $OPT_SUPPORTED -eq 0 ]; then
	echo "Error: check your supported version : $1"
	echo "Supported version: $SUPPORTED_VERSIONS"
	exit 0
fi

if [ -e $TEST_PATH ]; then
    rm -rf ./releases/*.tar.gz
else
    mkdir releases
fi

cd releases

# wget --content-disposition "http://git.videolan.org/?p=ffmpeg.git;a=snapshot;h=HEAD;sf=tgz"

if [ $OPT_VER22 -eq 1 ]; then
	if [ ! -e "/ffmpeg-2.2.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-2.2.tar.gz
	fi
fi

if [ $OPT_VER21 -eq 1 ]; then
	if [ ! -e "/ffmpeg-2.1.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-2.1.tar.gz
	fi
fi

if [ $OPT_VER112 -eq 1 ]; then
	if [ ! -e "ffmpeg-1.1.2.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-1.1.2.tar.gz
	fi
fi

if [ $OPT_VER104 -eq 1 ]; then
	if [ ! -e "ffmpeg-1.0.4.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-1.0.4.tar.gz
	fi
fi

if [ $OPT_VER0112 -eq 1 ]; then
	if [ ! -e "ffmpeg-0.11.2.tar.gz" ]; then 
		wget http://ffmpeg.org/releases/ffmpeg-0.11.2.tar.gz
	fi
fi

if [ $OPT_VER0106 -eq 1 ]; then
	if [ ! -e "ffmpeg-0.10.6.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-0.10.6.tar.gz
	fi
fi

if [ $OPT_VER092 -eq 1 ]; then
	if [ !-e "ffmpeg-0.9.2.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-0.9.2.tar.gz
	fi
fi

if [ $OPT_VER0812 -eq 1 ]; then
	if [ ! -e "ffmpeg-0.8.12.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-0.8.12.tar.gz
	fi
fi

if [ $OPT_VER0714 -eq 1 ]; then
	if [ ! -e "ffmpeg-0.7.14.tar.gz" ]; then
		wget http://ffmpeg.org/releases/ffmpeg-0.7.14.tar.gz
	fi
fi

cd ..

