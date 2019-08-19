#!/bin/bash

#######################################
###     INSTALL PACKAGES            ###
#######################################

sudo apt-get -y install $(grep -vE "^\s*#" packages/apt_packages  | tr "\n" " ") > /dev/null
snap install $(grep -vE "^\s*#" packages/snap_packages  | tr "\n" " ") --classic > /dev/null
success "packages installed"

#######################################
###     REMOVE PWD FEEDBACK         ###
#######################################

if [ -f /etc/sudoers.d/0pwfeedback ]; then 
	sudo mv /etc/sudoers.d/0pwfeedback /etc/sudoers.d/0pwfeedback.disabled 
	success "removed password feedback"
else 
	info "no password feedback"
fi

#######################################
###     DESKTOP APPEARANCE          ###
#######################################

mkdir -p $HOME/Pictures/Wallpapers/
sudo wget -O $HOME/Pictures/Wallpapers/dragon.jpg "https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg"
sudo wget -O $HOME/Pictures/Wallpapers/flow.jpg "https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg"
gsettings set org.cinnamon.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/dragon.jpg"

sudo sed -i "s/draw-user.*/draw-user-background=true/g" /etc/lightdm/slick-greeter.conf
sudo sed -i "s/draw-grid.*/draw-grid=false/g" /etc/lightdm/slick-greeter.conf
success "desktop is set up"

#######################################
###     EXTENSIONS                  ###
#######################################

sudo wget -P $HOME/.local/share/cinnamon/extensions/ https://cinnamon-spices.linuxmint.com/files/extensions/cinnamon-maximus@fmete.zip
sudo wget -P $HOME/.local/share/cinnamon/extensions/ https://cinnamon-spices.linuxmint.com/files/extensions/gTile@shuairan.zip
unzip $HOME/.local/share/cinnamon/extensions/\*.zip -d $HOME/.local/share/cinnamon/extensions/
rm -f $HOME/.local/share/cinnamon/extensions/\*.zip
gsettings set org.cinnamon enabled-extensions "['gTile@shuairan', '!cinnamon-maximus@fmete']"
success "installed extensions"

#######################################
###     WORKSPACE SETTINGS          ###
#######################################

# download adapta themes
sudo apt-add-repository ppa:tista/adapta -y
sudo apt-get update
sudo apt-get install -y adapta-gtk-theme

# set adapta theme
gsettings set org.cinnamon.desktop.wm.preferences theme 'Adapta-Nokto'
gsettings set org.cinnamon.theme name 'Adapta-Nokto'
gsettings set org.cinnamon.desktop.interface gtk-theme 'Adapta-Nokto'
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Grey'

# disable sounds
gsettings set org.cinnamon.desktop.sound volume-sound-enabled false
gsettings set org.cinnamon.desktop.sound event-sounds false
gsettings set org.cinnamon.sounds login-enabled false
gsettings set org.cinnamon.sounds logout-enabled false
gsettings set org.cinnamon.sounds switch-enabled false
gsettings set org.cinnamon.sounds tile-enabled false
gsettings set org.cinnamon.sounds plug-enabled false
gsettings set org.cinnamon.sounds unplug-enabled false

# hide icons
gsettings set org.nemo.desktop computer-icon-visible false
gsettings set org.nemo.desktop home-icon-visible false
gsettings set org.nemo.desktop trash-icon-visible false
gsettings set org.nemo.desktop network-icon-visible false
gsettings set org.nemo.desktop volumes-visible false

#workspace settings
gsettings set org.cinnamon workspace-osd-visible false
gsettings set org.cinnamon.muffin workspace-cycle true
gsettings set org.cinnamon.muffin workspaces-only-on-primary true
gsettings set org.cinnamon workspace-expo-view-as-grid false

# visual settings
gsettings set org.cinnamon.desktop.wm.preferences focus-mode 'click'
gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
gsettings set org.cinnamon panels-autohide "['1:true']"
gsettings set org.cinnamon panels-height "['1:30']"
gsettings set org.cinnamon startup-animation false
success "workspace settings updated"

#######################################
###     SYMLINKS                    ###
#######################################

ln -sf $HOME/.dotfiles/config/tmux $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/config/vscode $HOME/.config/Code/User/settings.json

success "symlinks created"
