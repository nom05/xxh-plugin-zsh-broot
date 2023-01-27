#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done

portable_url='https://github.com/Canop/broot/releases/download/v1.19.0/broot_1.19.0.zip'
tarname=`basename $portable_url`

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

if [ -x "$(command -v wget)" ]; then
  wget $arg_q $arg_progress $portable_url -O $tarname
elif [ -x "$(command -v curl)" ]; then
  curl $arg_s -L $portable_url -o $tarname
else
  echo Install wget or curl
fi

unzip $tarname
# Rename the architecture you need to bin and remove the other ones
mv x86_64-unknown-linux-musl bin
rm -rf  armv7-unknown-linux-gnueabihf \
        broot.1                       \
        CHANGELOG.md                  \
        install.md                    \
        resources                     \
        x86_64-linux                  \
        x86_64-pc-windows-gnu         \
        x86_64-unknown-linux-gnu   #  \
#       x86_64-unknown-linux-musl
rm $tarname
