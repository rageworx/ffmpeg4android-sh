#!/bin/bash
# Android NDK build scripter , (C)2015 Raphael Kim <rage.kim@gmail.com> or <rageworx@gmail.com>

if [ ! -e "${PWD}/Android.mk" ]; then
    echo "Error: Android.mk does not exist, skipping Android compilation."
    exit 0
fi

if [ -e "`which ndk-build`" ]; then
    VERSION="`./version.sh`"
    BUILD_PATH="ndk-build-$VERSION"
	if [ -e $BUILD_PATH ]; then
	    rm -rf $BUILD_PATH
	fi
	mkdir -p $BUILD_PATH/jni
    ln -s ${PWD} $BUILD_PATH/jni/ffmpeg-$VERSION
    rm -rf $BUILD_PATH/jni/ffmpeg-$VERSION/android
    echo 'include $(call all-subdir-makefiles)' > $BUILD_PATH/jni/Android.mk
    LIBS=""
    for LIB in avcodec \
               avdevice \
               avfilter \
               avformat \
               avresample \
               avutil \
               swresample \
               swscale; 
    do
        LIBS="$LIBS $LIB-$VERSION"
    done
    
    echo "APP_MODULES := $LIBS" > $BUILD_PATH/jni/Application.mk
    echo "APP_ABI := armeabi armeabi-v7a x86 mips" >> $BUILD_PATH/jni/Application.mk
    echo "APP_PLATFORM := android-9" >> $BUILD_PATH/jni/Application.mk
    ndk-build -C $BUILD_PATH -j8 2>&1 | tee $BUILD_PATH/build.log
else
    echo "Error: ndk-build is not possible."
fi
