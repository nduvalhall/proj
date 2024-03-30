#!/usr/bin/env bash

# remove proj.sh from /usr/local/bin
sudo rm /usr/local/bin/proj.sh

# remove from bashrc
sed -i '/source \/usr\/local\/bin\/proj.sh/d' $HOME/.bashrc
