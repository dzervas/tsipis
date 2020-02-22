#!/bin/sh

VBOX_VERSION=$(vboxmanage --version | command grep -oP "\d\.\d\.\d")
EXTPACK="/tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack"

wget "https://download.virtualbox.org/virtualbox/${VBOX_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack" -O "${EXTPACK}"
vboxmanage extpack install "${EXTPACK}"
rm "${EXTPACK}"
