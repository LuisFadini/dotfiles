#!/usr/bin/env bash
echo "Adopting config files with GNU Stow"
stow --adopt .

echo "Adding permission to execute wofi-wifi-menu"
chmod +x scripts/wofi-wifi.sh
echo "Creating symlink for wofi-wifi-menu"
if ! command -v wofi-wifi-menu 2>&1 >/dev/null; then
  echo "Symlink created"
  sudo ln -s $(pwd)/scripts/wofi-wifi.sh /usr/local/bin/wofi-wifi-menu
else
  echo "Symlink already exists"
fi


