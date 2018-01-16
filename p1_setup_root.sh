#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "You should be root user to run this shell script."
	exit 1
fi

# change default password
echo root:tmxhflwl | chpasswd
echo odroid:tmxhflwl | chpasswd

# time zone
timedatectl set-timezone Asia/Seoul

# NTP
NTP_CONF=/etc/ntp.conf
grep "^pool " $NTP_CONF
if [ $? -eq 0 ]; then
    sed -i "s/\(^pool .*\)/#\1/" $NTP_CONF
    sed -i "/pool ntp.ubuntu.com/apool 1.kr.pool.ntp.org\npool 1.asia.pool.ntp.org\npool 2.asia.pool.ntp.org" $NTP_CONF
fi
systemctl enable ntp
systemctl start ntp

# disable saiarcot sourcelist
SAIARCOT895=/etc/apt/sources.list.d/saiarcot895-ubuntu-myppa-xenial.list
mv -f $SAIARCOT895 ${SAIARCOT895}~

# apt : install packages
apt update
apt -y install git nodejs strace rsync htop vim apache2 yajl-tools curl python3-urllib3 python3-certifi

# add user for storj. default password is tmxhflwl
adduser --gecos '' --disabled-password storj
echo storj:tmxhflwl | chpasswd

# root's bashrc
echo "set ai cindent 
set ts=4 sw=4
colo ron" > /root/.vimrc
echo "export EDITOR=/usr/bin/vim" >> /root/.bash_aliases

# set up sudoers
cat <<HERE >/etc/sudoers.d/storj
Cmnd_Alias      ADMIN_TOOLS = /usr/bin/apt, /usr/bin/nmcli, /bin/ss, /bin/systemctl, /sbin/poweroff, /sbin/reboot
storj   ALL = (ALL) NOPASSWD : ADMIN_TOOLS
HERE

# end of post-install 1.
