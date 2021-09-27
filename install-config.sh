#!/bin/bash
ROOT_DIR=$(pwd)
CONFIG_INSTALL_DIR=~/.config

# get dependencies to build i3 gaps
sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev

# get i3 gaps
#sudo apt purge i3
git clone https://github.com/Airblader/i3.git i3-gaps
cd i3-gaps
mkdir build && cd build
meson --prefix /usr/local
ninja
sudo ninja install
cd $ROOT_DIR

# get other programs that we use
sudo apt install polybar conky xterm qutebrowser  

# create sym links to our config folders
for d in "config/"*
do
	SRC_NAME=$ROOT_DIR/$d
	DEST_NAME=$CONFIG_INSTALL_DIR/$(basename "$d")
	rm -d -r -f $DEST_NAME
	ln -f -s $SRC_NAME $DEST_NAME
done

#clear
echo installation complete.  you should now be able to restart into i3

ls $CONFIG_INSTALL_DIR
