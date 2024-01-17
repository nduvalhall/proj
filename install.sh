#!/bin/bash

# install fzf
fzf=$(which fzf)

if [ -n "$fzf" ]; then
    echo "fzf already installed"

else
    apt=$(which apt)
    dnf=$(which dnf)

    if [ -n "$apt" ]; then
        sudo apt install fzf
    elif [ -n "$dnf" ]; then
        sudo dnf install fzf
    else
        echo "Error: no apt or dnf found, please install fzf manually"
        exit 1
    fi
fi

# copy proj.sh to /usr/local/bin
sudo cp ./proj.sh /usr/local/bin/

# check if already in .bashrc
if grep -q "source /usr/local/bin/proj.sh" ~/.bashrc; then
    exit 0
fi

# add proj.sh to ~/.bashrc
echo "" >> ~/.bashrc
echo "#used for proj tool" >> ~/.bashrc
echo "source /usr/local/bin/proj.sh" >> ~/.bashrc
echo "" >> ~/.bashrc
