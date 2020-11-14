#!/bin/bash -xe
echo "Installing libraries"
sudo dnf install python3-devel libusb-devel libusbx-devel libudev-devel systemd-devel
echo "Adding udev rules and reloading"

sudo tee /etc/udev/rules.d/99-streamdeck.rules << EOF
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", MODE:="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", MODE:="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", MODE:="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", MODE:="0666"
EOF

sudo udevadm control --reload-rules

echo "Unplug and replug in device for the new udev rules to take effect"
echo "Installing streamdeck_ui"
pip3 install --user streamdeck_ui
echo "If the installation was successful, run 'streamdeck' to start."
