#!/bin/bash

if [ $USER != "storj" ]; then
	echo "You should be storj user to run this shell script. But you are ${USER}."
	exit 1
fi

# phase 1 : setup vimrc/bash_aliases
echo "set ai cindent
set ts=4 sw=4
colo ron" > ${HOME}/.vimrc

echo "OLDPS1=$PS1
PS1='[\D{%H:%M:%S} \[\e[33m\]STORJ@\u\[\e[0m\] \W]\$ '

# User specific aliases and functions
alias enus='export LANG=en_US.utf8'
alias sjstatus='storjshare status'
alias sjlog='storjshare logs'
alias sjdaemon='storjshare daemon'
alias sjkillall='storjshare killall'

export TERM='xterm-256color'" > ${HOME}/.bash_aliases

# phase 2 : install nvm/npm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

export NVM_DIR="/home/storj/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install --lts

npm install --global storjshare-daemon

# phase 3 : install shell script
if [ ! -d $HOME/bin ]; then
	mkdir $HOME/bin
fi

