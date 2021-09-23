#/bin/bash
#TODO: Auto compile on new kernel versions
#       https://wiki.debian.org/KernelDKMS

# deps
sudo apt install cargo dbus rustc systemd openssl librust-dbus-dev librust-openssl-dev librust-lzma-sys-dev librust-x11-dev libxrandr-dev

git clone https://github.com/pop-os/system76-firmware.git
cd system76-firmware
make all
sudo make install
cd ../
rm -d -r -f system76-firmware

# its called a driver... but its actually just a program to manage things
# it looks to be pre-built so we should maybe jsut move them to where they would be relevant 
# for the system
# git clone https://github.com/pop-os/system76-driver.git
# cd system76-driver
# cd ../ 
# rm -d -r -f system76-driver

# build and install the kernel module
# NOTE: we should automate this for every kernel
# NOTE: The darp6 doesnt need this
# KERNEL_VERSION = $(shell uname -r)
# sudo apt install linux-headers-$KERNEL_VERSION
# git clone https://github.com/pop-os/system76-dkms.git
# cd system76-dkms
# make
# sudo modprobe wmi
# sudo modprobe -r system76
# sudo insmod system76.ko
# cd ../
# rm -d -r -f system76-dkms

git clone https://github.com/pop-os/system76-io-dkms.git
cd system76-io-dkms
make
sudo modprobe wmi
sudo insmod system76-io.ko
cd ../
rm -d -r -f system76-io-dkms

git clone https://github.com/pop-os/system76-acpi-dkms.git
cd system76-acpi-dkms
make
sudo insmod system76_acpi.ko
cd ../
rm -d -r -f system76-acpi-dkms

git clone https://github.com/pop-os/system76-oled.git
cd system76-oled
make
sudo make install
cd ../
rm -d -r -f system76-oled