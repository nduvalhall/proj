#!/usr/bin/env bash

# install fzf
fzf=$(which fzf)

if [ ! -f $fzf ]; then
	echo "fzf not found. Please install fzf first"
	exit 1
fi

# copy proj.sh to /usr/local/bin
sudo cp ./proj.sh /usr/local/bin/

# check if already in .bashrc
if grep -q "source /usr/local/bin/proj.sh" $HOME/.bashrc; then
	exit 0
fi

# add proj.sh to $HOME/.bashrc
echo "source /usr/local/bin/proj.sh" >>$HOME/.bashrc
