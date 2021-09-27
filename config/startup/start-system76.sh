#!/bin/bash

if [ -e /opt/system76-drivers/install-drivers.sh ]
	sudo /opt/system76-drivers/install-drivers.sh
else
	# try to build everything. probably not a good idea
	#git clone https://github.com/RetroZelda/system76-scripts.git /tmp/system76-scripts
	#cd /tmp/system76-scripts
	#./build-drivers.sh
fi
