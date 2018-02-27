#! /usr/bin/env bash

THEME='poly-light'
LANG='English'

# Pre-authorise sudo
sudo echo

# Select language, optional
declare -A LANGS=(
    [Chinese]=zh_CN
    [English]=EN
    [French]=FR
    [German]=DE
    [Norwegian]=NO
    [Portuguese]=PT
    [Russian]=RU
    [Ukrainian]=UA
)

LANG_NAMES=($(echo ${!LANGS[*]} | tr ' ' '\n' | sort -n))

PS3='Please select language #: '
select l in "${LANG_NAMES[@]}"
do
    if [[ -v LANGS[$l] ]]
    then
        LANG=$l
        break
    else
        echo 'No such language, try again'
    fi
done < /dev/tty


echo 'Fetching theme archive'
wget https://github.com/shvchk/$THEME/archive/master.zip

echo 'Unpacking theme'
unzip master.zip

if [[ "$LANG" != "English" ]]
then
    echo "Changing language to ${LANG}"
    sed -i -r -e '/^\s+# EN$/{n;s/^(\s*)/\1# /}' \
              -e '/^\s+# '"${LANGS[$LANG]}"'$/{n;s/^(\s*)#\s*/\1/}' $THEME-master/theme.txt
fi

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
