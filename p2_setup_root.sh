#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "You should be root user to run this shell script."
	exit 1
fi

DISK_TARGET=/dev/sda
FSTABLE=/etc/fstab

# phase 1 : make partition/fs (DO NOT DELETE BLANK LINE ON echo COMMAND.)
echo "$DISK_TARGET : Wipe disk & make partion/filesystem"
dd if=/dev/zero of=${DISK_TARGET} bs=512 count=1 2>/dev/null
echo "n
p
1


w
" | fdisk $DISK_TARGET >/dev/null
mkfs.ext4 -F ${DISK_TARGET}1
echo "$DISK_TARGET : Done"

# phase 2 : update /etc/fstab
# backup fstab
cp $FSTABLE ${FSTABLE}.backup
grep "/dev/sda1" $FSTABLE
if [ $? -eq 1 ]; then
	echo "fstab : Append a line"
	echo "/dev/sda1 /media/sda1 ext4 errors=continue 0 1" >> $FSTABLE
else
	echo "fstab : Replace a line on /dev/sda1"
	sed -i "/\/dev\/sda1 .*/c\/dev\/sda1 \/media\/sda1 ext4 errors=continue 0 1" $FSTABLE 
fi

# phase 3 : make dirs for storj
DIR_MEDIA=/media/sda1
if [ ! -d $DIR_MEDIA ]; then
    mkdir $DIR_MEDIA
fi
mount $DIR_MEDIA
mkdir -p ${DIR_MEDIA}/node{1..8}
chown -R storj.storj ${DIR_MEDIA}

cp -a p3_setup_storj.sh bin ~storj/
chown -R storj.storj ~storj/bin p3_setup_storj.sh
