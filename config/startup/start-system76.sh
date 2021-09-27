#!/bin/bash

INSTALL_DRIVERS=/opt/system76-drivers/install-drivers.sh
if [ -f "$INSTALL_DRIVERS" ]; then
	sudo $INSTALL_DRIVERS
else
	echo missing installation script: $INSTALL_DRIVERS
	echo install things from here: https://github.com/RetroZelda/system76-scripts.git
fi
