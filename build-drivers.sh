#/bin/bash
#TODO: Auto compile on new kernel versions
#       https://wiki.debian.org/KernelDKMS

DRIVER_INSTALL_DIR=/opt/system76-drivers
DRIVER_INSTALL_SCRIPT=$DRIVER_INSTALL_DIR/install-drivers.sh
DRIVER_SUDOER_FILE=/etc/sudoers.d/system76-drivers
# deps
sudo apt install cargo dbus rustc systemd openssl librust-dbus-dev librust-openssl-dev librust-lzma-sys-dev librust-x11-dev libxrandr-dev

# driver output dir
sudo rm -d -r -f $DRIVER_INSTALL_DIR
sudo mkdir $DRIVER_INSTALL_DIR
sudo touch $DRIVER_INSTALL_SCRIPT
sudo chmod +x $DRIVER_INSTALL_SCRIPT
echo "#!/bin/bash" |  sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null
echo modprobe wmi | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null

git clone https://github.com/pop-os/system76-firmware.git
cd system76-firmware
make all
sudo make install
cd ../

git clone https://github.com/pop-os/system76-driver.git
cd system76-driver
python3 ./setup.py build
sudo python3 ./setup.py install
cd ../ 

# build and install the kernel module
KERNEL_VERSION = $(shell uname -r)
sudo apt install linux-headers-$KERNEL_VERSION
git clone https://github.com/pop-os/system76-dkms.git
cd system76-dkms
make
sudo cp system76-io.ko $DRIVER_INSTALL_DIR
echo modprobe -r system76 | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
echo insmod $DRIVER_INSTALL_DIR/system76.ko | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
cd ../

git clone https://github.com/pop-os/system76-io-dkms.git
cd system76-io-dkms
make
sudo cp system76-io.ko $DRIVER_INSTALL_DIR
echo modprobe -r system76-io | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
echo insmod $DRIVER_INSTALL_DIR/system76-io.ko | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
cd ../

git clone https://github.com/pop-os/system76-acpi-dkms.git
cd system76-acpi-dkms
make
sudo cp system76_acpi.ko $DRIVER_INSTALL_DIR
echo modprobe -r system76_acpi | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
echo insmod $DRIVER_INSTALL_DIR/system76_acpi.ko | sudo tee -a $DRIVER_INSTALL_SCRIPT >> /dev/null 
cd ../

git clone https://github.com/pop-os/system76-oled.git
cd system76-oled
make
sudo make install
cd ../

clear
echo building system76 modules complete!
sleep 1
echo making sudo override...
sudo touch $DRIVER_SUDOER_FILE
LOGNAME=`logname`
sudo echo "${LOGNAME} ALL=(ALL) NOPASSWD: $DRIVER_INSTALL_SCRIPT" | sudo tee $DRIVER_SUDOER_FILE > /dev/null
sudo chmod 0440 $DRIVER_SUDOER_FILE
echo run $DRIVER_INSTALL_SCRIPT on each boot to install drivers
