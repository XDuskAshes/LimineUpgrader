#!/bin/bash

# LimineUpgrader - By Dusk - Released under The Unlicense
# Not official or endorsed by Limine in any way, shape, or form
# https://github.com/XDuskAshes/LimineUpgrader/
#
# This script is for UEFI only - anyone who wants
# to maintain a BIOS version is more than welcome!
# (im not sure if a script would be needed for that...)

LIMINE_INSTALL_PATH="/boot/EFI/BOOT" # Limine's installation path
LIMINE_EFI_PATH="/usr/share/limine/BOOTX64.EFI" # Limine's UEFI file path

cp -f "$LIMINE_EFI_PATH" "$LIMINE_INSTALL_PATH" # Forcefully replace (if not already there) BOOTX64.EFI in /boot/

# gonna be honest this part is kinda slapped together from like four stack overflow articles
# not 110% sure this works *properly* on all systems - please submit an issue if it doesn't
#
# i dont want to know why, i shouldnt have to wonder why, but this keeps making
# the exact same boot entry names under different numbers each time - TODO: fix this
efibootmgr | grep -q "Limine"
if [ $? -ne 0 ]; then
  efibootmgr --create --label "Limine" --disk /dev/sdX --part 1 --loader '\EFI\BOOT\BOOTX64.EFI'
fi

echo "If you experience issues after upgrading Limine, please check your UEFI settings and efibootmgr. Otherwise, submit an issue - <https://github.com/XDuskAshes/LimineUpgrader/>"
