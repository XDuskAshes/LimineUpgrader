#!/bin/bash

# LimineUpgrader - By Dusk - Released under The Unlicense
# Not official or endorsed by Limine in any way, shape, or form
# https://github.com/XDuskAshes/LimineUpgrader/
#
# This script is for UEFI only - anyone who wants
# to maintain a BIOS version is more than welcome!
# (im not sure if a script would be needed for that...)

if [ "$1" == "--warranty" ]; then
    echo "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE."
    exit 1
fi

LIMINE_INSTALL_PATH="/boot/EFI/BOOT" # Limine's installation path
LIMINE_EFI_PATH="/usr/share/limine/BOOTX64.EFI" # Limine's UEFI file path
PART_NAME="Arch Linux"
DISK_BY_DEV="/dev/sda" # Replace this with the name of the *DISK* you have Limine on.

echo "-- LimineUpgrader --"
echo "Installing $LIMINE_EFI_PATH to $LIMINE_INSTALL_PATH"
echo "Partition name: $PART_NAME"
echo "Disk: $DISK_BY_DEV"

cp -f "$LIMINE_EFI_PATH" "$LIMINE_INSTALL_PATH/." # Forcefully replace (if not already there) BOOTX64.EFI in /boot/

# gonna be honest this part is kinda slapped together from like four stack overflow articles

efibootmgr | grep -q "$PART_NAME"
if [ $? -ne 0 ]; then
    echo "Boot entry must be made."
    efibootmgr --create --label "$PART_NAME" --disk $DISK_BY_DEV --part 1 --loader '\EFI\BOOT\BOOTX64.EFI'
fi

echo "If you experience post-install issues, please check UEFI settings and efibootmgr. Otherwise, submit an issue or check an existing one: <https://github.com/XDuskAshes/LimineUpgrader/issues>"
echo "DISCLAIMER: This script is unofficial and provided "as-is" without any warranty or guarantees."
echo "License: <https://github.com/XDuskAshes/LimineUpgrader/blob/main/LICENSE>"
echo "-- LimineUpgrader --"
