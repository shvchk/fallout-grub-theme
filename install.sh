#! /usr/bin/env sh

THEME='poly-light'

echo 'Fetching theme archive'
wget https://github.com/shvchk/$THEME/archive/master.zip

echo 'Unpacking theme'
unzip master.zip

echo 'Creating GRUB themes directory'
sudo mkdir -p /boot/grub/themes/$THEME

echo 'Copying theme to GRUB themes directory'
sudo cp -r $THEME-master/* /boot/grub/themes/$THEME

echo 'Removing other themes from GRUB config'
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub

echo 'Removing empty lines at the end of GRUB config' # optional
sudo sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /etc/default/grub

echo 'Adding new line to GRUB config just in case' # optional
echo | sudo tee -a /etc/default/grub

echo 'Adding theme to GRUB config'
echo "GRUB_THEME=/boot/grub/themes/$THEME/theme.txt" | sudo tee -a /etc/default/grub

echo 'Updating GRUB'
sudo update-grub

echo 'Removing theme installation files'
rm -rf master.zip $THEME-master
