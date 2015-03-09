ffmpeg for android with modified linux bash shells.
===================================================
(C)2015 Raphael Kim <rageworx@gmail.com>, rage.kim@gmail.com

Refered to source of Sergii Pylypenko's repository: http://sourceforge.net/u/pelya/ffmpeg4android/ci/master/tree/

Modified to get 2.2 and 2.1 version of ffmpeg.
Modified to get-ffmpeg-release.sh for easy control source of ffmpeg release.

Supported version of ffmpeg library:
2.2, 2.1, 1.1.2, 1.0.4, 0.11.2, 0.10.6, 0.9.2, 0.8.12, 0.7.14

Example:
To download 2.2, use ./get-ffmpeg-releases.sh 2.2
and it going to complete, use ./create-ffmpeg4android.sh to make tar.gz for android.

To build test:
Use buildtest.sh.
