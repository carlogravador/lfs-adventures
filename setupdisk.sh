#!/bin/bash

LFS_DISK="$1"

# create partition
sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
n
p
2


a
1
p
w
q
EOF

# create filesystem for partition
sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"
