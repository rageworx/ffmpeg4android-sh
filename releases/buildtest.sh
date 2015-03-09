
[ -z "$ANDROID_ROOT_DIR" ] && ANDROID_ROOT_DIR="/scratch/workareas/android"
[ -z "$FFMPEG4ANDROID_ROOT_DIR" ] && FFMPEG4ANDROID_ROOT_DIR="`pwd`"


for ffmpegdir in `find $ANDROID_ROOT_DIR/external/ffmpeg*.android -maxdepth 0 | sort -rV`
do
    rm $ffmpegdir
done


cd $FFMPEG4ANDROID_ROOT_DIR
FFMPEG_DIRS=`find ffmpeg*.android -maxdepth 0 | sort -rV`


if [ -e "$ANDROID_ROOT_DIR" ]; then
    cd $ANDROID_ROOT_DIR
    for ffmpegdir in $FFMPEG_DIRS
    do
        ln -s $FFMPEG4ANDROID_ROOT_DIR/$ffmpegdir $ANDROID_ROOT_DIR/external/
        rm -rf $ANDROID_ROOT_DIR/external/$ffmpegdir/android
        . build/envsetup.sh;
        lunch full-eng; cd $ANDROID_ROOT_DIR/external/$ffmpegdir; mm -Bj24; cd $ANDROID_ROOT_DIR;
        lunch full_mips-eng; cd $ANDROID_ROOT_DIR/external/$ffmpegdir; mm -Bj24; cd $ANDROID_ROOT_DIR;
        lunch full_x86-eng; cd $ANDROID_ROOT_DIR/external/$ffmpegdir; mm -Bj24; cd $ANDROID_ROOT_DIR;
        rm $ANDROID_ROOT_DIR/external/$ffmpegdir
    done
else
    echo "ANDROID_ROOT_DIR does not exist, skipping Android compilation test"
fi

if [ -e "`which ndk-build`" ]; then
    for ffmpegdir in $FFMPEG_DIRS
    do
        VERSION="`echo $ffmpegdir | sed 's/.*-\(.*\).android/\1/'`"
        cd $FFMPEG4ANDROID_ROOT_DIR
        rm -rf ndk-test-$VERSION
        mkdir -p ndk-test-$VERSION/jni
        ln -s $FFMPEG4ANDROID_ROOT_DIR/$ffmpegdir ndk-test-$VERSION/jni/ffmpeg-$VERSION
        rm -rf ndk-test-$VERSION/jni/ffmpeg-$VERSION/android
        echo 'include $(call all-subdir-makefiles)' > ndk-test-$VERSION/jni/Android.mk
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
        echo "APP_MODULES := $LIBS" > ndk-test-$VERSION/jni/Application.mk
        echo "APP_ABI := armeabi armeabi-v7a x86 mips" >> ndk-test-$VERSION/jni/Application.mk
        echo "APP_PLATFORM := android-9" >> ndk-test-$VERSION/jni/Application.mk
        ndk-build -C ndk-test-$VERSION -j8 2>&1 | tee ndk-test-$VERSION/build.log
    done
else
    echo "ndk-build is not in PATH, skipping NDK compilation test"
fi
