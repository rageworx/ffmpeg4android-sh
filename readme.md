ffmpeg for android with modified linux bash shells.
===================================================
(C)2015 Raphael Kim <rageworx@gmail.com>, rage.kim@gmail.com

### Refered to 
source of Sergii Pylypenko's repository
: http://sourceforge.net/u/pelya/ffmpeg4android/ci/master/tree/

# What it does?
- Download release tar.gz from ffmpeg web source with wget.
- (If you are using Cygwin or M-Sys/MinGW-Sys, it will also possible to works.)
- Automatically it generate android buildabled tar.gz from original source.

# What it changed from Sergii Pylypenko's source?
- Modified to get 2.2 and 2.1 version of ffmpeg.
- Modified to get-ffmpeg-release.sh for easy control source of ffmpeg release.

# Supported versions of ffmpeg library
- 2.2
- 2.1 
- 1.1.2 
- 1.0.4 
- 0.11.2 
- 0.10.6 
- 0.9.2 
- 0.8.12 
- 0.7.14

## What you can do?
- First, download 2.2, by use shell script "get-ffmpeg-releases.sh 2.2" (be sure you are on line)
- Downloaded files will placed in directory of "releases".
- And it going to complete, use shell script "create-ffmpeg4android.sh" to make tar.gz for android.
- Modified files will store in directory of "releases.android".
- You can move modified tar.gz to another place of your directory,
- Extract tar.gz, then move to extracted directory.
~~~~~
tar -zxvf ffmpeg-2.2.tar.gz
~~~~~
- just use "build.sh" in extracted directory.
