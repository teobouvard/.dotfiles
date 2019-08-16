#!/bin/bash

###################################
###     DISPLAY FUNCTIONS       ###
###################################

info() {
	printf "["
	tput setaf 3
	tput bold
	printf "INFO"
	tput setaf 7
	printf "] "
 	echo $*	
	tput sgr0
}

success() {
	printf "["
	tput setaf 2
	tput bold
	printf "OK"
	tput setaf 7
	printf "] "
	echo $*	
	tput sgr0
}

error() {
	printf "["
	tput setaf 1
	tput bold
	printf "ERROR"
	tput setaf 7
	printf "] "
	echo $*	
	tput sgr0
}

#######################################
###     INSTALL PACKAGES            ###
#######################################

sudo apt-get -y install $(grep -vE "^\s*#" packages  | tr "\n" " ") > /dev/null
success "packages installed"

#######################################
###     INSTALL ZSH SHELL           ###
#######################################

sudo git-force-clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh > /dev/null
sudo chsh -s $(which zsh)
success "Oh My Zsh installed"

#######################################
###     COLOR PALETTE               ###
#######################################

# Neutron, Oceanic Next, Pencil Dark
bash -c  "$(wget -qO- https://git.io/vQgMr)"

#######################################
###     INSTALL REFIND              ###
#######################################

sudo apt-add-repository -y ppa:rodsmith/refind > /dev/null
sudo apt-get update > /dev/null
sudo apt-get -y install refind
sudo refind-install
success "installed refind"

sudo git-force-clone https://github.com/andersfischernielsen/rEFInd-minimal-black.git /boot/efi/EFI/refind/themes/
success "installed refind theme"

#######################################
###     REMOVE PWD FEEDBACK         ###
#######################################

if [ -f /etc/sudoers.d/0pwfeedback ];
	then sudo mv /etc/sudoers.d/0pwfeedback /etc/sudoers.d/0pwfeedback.disabled 
	success "removed password feedback"
else 
	info "no password feedback"
fi

#######################################
###     DESKTOP APPEARANCE          ###
#######################################

mkdir -p $HOME/Pictures/Wallpapers/
sudo wget -O $HOME/Pictures/Wallpapers/dragon.jpg https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg
sudo wget -O $HOME/Pictures/Wallpapers/flow.jpg https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg
gsettings set org.cinnamon.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/dragon.jpg"

sudo sed -i "s/draw-user.*/draw-user-background=true/g" /etc/lightdm/slick-greeter.conf
sudo sed -i "s/draw-grid.*/draw-grid=false/g" /etc/lightdm/slick-greeter.conf
success "desktop is set up"

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
gsettings set org.cinnamon panels-autohide "['1,true']"
gsettings set org.cinnamon panels-height "['1,30']"
gsettings set org.cinnamon startup-animation false
success "workspace settings updated"

#######################################
###     SET UP GIT                  ###
#######################################

git config --global user.email "teobouvard@gmail.com"
git config --global user.name "Téo Bouvard"
git config --global credential.helper store
git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
success "git settings updated" 

#######################################
###     SYMLINKS                    ###
#######################################

ln -sf .dotfiles/.zshrc $HOME/.zshrc
ln -sf .dotfiles/.tmux.conf $HOME/.tmux.conf
success "symlinks created"
