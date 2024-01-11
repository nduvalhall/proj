#!/bin/bash

# copy proj.sh to /usr/local/bin
sudo cp ./proj.sh /usr/local/bin/

# add proj.sh to ~/.bashrc
echo "" >> ~/.bashrc
echo "#used for proj tool" >> ~/.bashrc
echo "source /usr/local/bin/proj.sh" >> ~/.bashrc
echo "" >> ~/.bashrc
