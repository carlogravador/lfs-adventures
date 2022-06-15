#!/bin/bash

# define env variable LFS which value is your mount point
export LFS=/mnt/lfs
# define env variable LFS_TGT which value is your target
export LFS_TGT=x86_64_lfs-linux-gnu
# define env variable LFS_DISK which value is your usb name
export LFS_DISK=/dev/sda

# check if $LFS is not mounted
if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS"
    sudo chown -v "$USER" "$LFS"
fi

mkdir -pv $LFS/tools
mkdir -pv $LFS/sources

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

case $(uname -m) in 
    x86_64) mkdir -pv $LFS/lib64 ;;
esac

# copy scripts and packages.csv to sources dir in LFS
cp -rf *.sh packages.csv "$LFS/sources"

cd "$LFS/sources"

# append tools/bin to path
export PATH="$LFS/tools/bin:$PATH"

source download.sh
