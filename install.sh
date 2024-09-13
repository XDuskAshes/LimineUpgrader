#!/bin/bash

# LimineUpgrader install script - By Dusk - Released under The Unlicense

# Assuming we're running in the *intended* way, with src/limine-update.hook and src/update-limine.sh

echo "We require sudo to add to /etc/pacman.d/ and /usr/local/bin/"
sudo echo "Proceeding!" # placeholding

if [ ! -d "/etc/pacman.d/hooks/" ]; then
	echo "Create: /etc/pacman.d/hooks/"
	sudo mkdir -p /etc/pacman.d/hooks
else
	echo "Exists: /etc/pacman.d/hooks/"
fi

echo "Copying src/limine-update.hook into /etc/pacman.d/hooks/"
sudo cp -f src/limine-update.hook /etc/pacman.d/hooks/limine-update.hook
echo "Copying src/update-limine.sh into /usr/local/bin/"
sudo cp -f src/update-limine.sh /usr/local/bin/

echo "Setup permissions for update-limine.sh"
sudo chmod +x /usr/local/bin/update-limine.sh
sudo chown root:root /usr/local/bin/update-limine.sh

echo "Setup permissions for limine-update.hook"
sudo chmod 664 /etc/pacman.d/hooks/limine-update.hook
