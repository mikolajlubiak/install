#!/bin/bash
su -c $'echo "UUID=bfb2620a-86ab-4252-94f3-82f5da477c98   /mnt/HDD        btrfs   defaults,noatime,discard=async      0 0" >> /etc/fstab'
sudo mount --mkdir -a
ln -sf /mnt/HDD/code $HOME/Code
ln -sf /mnt/HDD/downloads $HOME/Downloads
ln -sf /mnt/HDD/git $HOME/Git
ln -sf /mnt/HDD/key $HOME/Key
ln -sf /mnt/HDD/music $HOME/Music
mpc update
ln -sf /mnt/HDD/notes $HOME/Notes
ln -sf /mnt/HDD/other $HOME/Other
ln -sf /mnt/HDD/pass $HOME/.local/share/password-store
ln -sf /mnt/HDD/notes/dmenurecord $HOME/.local/bin/dmenurecord
mkdir $HOME/.local/share/nvim/vimwiki
ln -sf /mnt/HDD/notes/index.md $HOME/.local/share/nvim/vimwiki/index.md
ln -sf /mnt/HDD/notes/rss.txt $HOME/.config/newsboat/urls
ln -sf /mnt/HDD/notes/snippets $HOME/.local/share/larbs/snippets
mkdir $HOME/.config/lapce-stable
ln -sf /mnt/HDD/notes/lapce.toml $HOME/.config/lapce-stable/settings.toml
mkdir $HOME/.config/transmission-daemon
ln -sf /mnt/HDD/notes/transmission.json $HOME/.config/transmission-daemon/settings.json
gpg --import /mnt/HDD/key/*.pgp
mkdir -m 700 $HOME/.ssh
ln -s /mnt/HDD/key/ssh.private.ssh $HOME/.ssh/id_ed25519
ln -s /mnt/HDD/key/ssh.public.ssh $HOME/.ssh/id_ed25519.pub
/mnt/HDD/notes/hwaccel.sh
sudo groupadd $USER
sudo usermod -aG wheel,rfkill,sys,$USER,lp,video,network,storage,wheel,audio $USER
echo $'alias mpv="mpv --hwdec=auto"' >> $HOME/.config/shell/aliasrc
echo $'alias ffmpeg="ffmpeg -threads 4 -vaapi_device /dev/dri/renderD129 -hwaccel vaapi -hwaccel_output_format vaapi"' >> $HOME/.config/shell/aliasrc
echo $'
Section "InputClass"
        Identifier "libinput keyboard catchall"
        MatchIsKeyboard "on"
        Option "XkbLayout" "pl"
        Option "XkbModel" "pc105"
EndSection
' | sudo tee -a /etc/X11/xorg.conf.d/40-libinput.conf
sed -i $'s/+%Y %b %d (%a) $icon%I:%M%p/+%d.%m.%Y $icon%H:%M/' $HOME/.local/bin/statusbar/sb-clock
sed -i $'s/dmenu -i -l 50/dmenu -i -l 35/' $HOME/.local/src/dwm/config.h
sed -i $'s/#770000/#61001B/' $HOME/.local/src/dwm/config.h
sed -i $'s/#005577/#402060/' $HOME/.local/src/dwm/config.h
cd $HOME/.local/src/dwm && make && sudo make install && cd $HOME
patch $HOME/.local/src/dwmblocks/config.h < /mnt/HDD/notes/dwmblocks.patch
cd $HOME/.local/src/dwmblocks && make && sudo make install && cd $HOME
sudo pacman -S --needed sdl2_image sdl2
sudo pacman -S --needed acpilight
sudo pacman -S --needed freetube-bin
yay -S --needed dashbinsh
