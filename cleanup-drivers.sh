#/bin/bash

DRIVER_INSTALL_DIR=/opt/system76-drivers
DRIVER_SUDOER_FILE=/etc/sudoers.d/system76-drivers

# stop services
sudo modprobe -r system76_acpi
sudo modprobe -r system76-io
sudo modprobe -r system76

# uninstalls
cd system76-oled && sudo make uninstall && cd ../
cd system76-firmware && sudo make uninstall && cd ../
# cd system76-driver && sudo python3 ./setup.py uninstall && cd ../

# remove local dirs
rm -d -r -f system76-oled
rm -d -r -f system76-acpi-dkms
rm -d -r -f system76-io-dkms
rm -d -r -f system76-dkms
rm -d -r -f system76-driver
rm -d -r -f system76-firmware

# remove system directories
sudo rm -d -r -f $DRIVER_INSTALL_DIR
sudo rm -f $DRIVER_SUDOER_FILE

