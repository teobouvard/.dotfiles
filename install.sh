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
}

success() {
	printf "["
	tput setaf 2
	tput bold
	printf "OK"
	tput setaf 7
	printf "] "
	echo $*	
}

error() {
	printf "["
	tput setaf 1
	tput bold
	printf "ERROR"
	tput setaf 7
	printf "] "
	echo $*	
}

#######################################
###     INSTALL PACKAGES            ###
#######################################

sudo apt-get -y install $(grep -vE "^\s*#" packages  | tr "\n" " ")
success "packages installed"

#######################################
###     INSTALL ZSH SHELL           ###
#######################################

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
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

if [ -d /boot/efi/EFI/refind/ ];
	then info "refind already installed"
	sudo refind-install
else
	sudo apt-add-repository -y ppa:rodsmith/refind
	sudo apt-get update
	sudo apt-get -y install refind
	sudo refind-install
	success "refind installed"
fi

git clone https://github.com/andersfischernielsen/rEFInd-minimal-black.git /boot/efi/EFI/refind/themes/
success "installed refind theme"

#######################################
###     REMOVE PWD FEEDBACK         ###
#######################################

sudo mv /etc/sudoers.d/0pwfeedback /etc/sudoers.d/0pwfeedback.disabled 
success "removed password feedback"

#######################################
###     DESKTOP APPEARANCE          ###
#######################################

mkdir -p $HOME/Pictures/Wallpapers/
curl --output $HOME/Pictures/Wallpapers/dragon.jpg https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg
curl --output $HOME/Pictures/Wallpapers/flow.jpg https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg
gsettings set org.cinnamon.desktop.background picture-uri "file://$HOME/Pictures/Wallpapers/dragon.jpg"
success "desktop is set up"

#######################################
###     GSETTINGS                   ###
#######################################

sudo apt-add-repository ppa:tista/adapta -y
sudo apt-get update
sudo apt-get install -y adapta-gtk-theme

gsettings set org.cinnamon.desktop.wm.preferences theme 'Adapta-Nokto'
gsettings set org.cinnamon.theme name 'Adapta-Nokto'
gsettings set org.cinnamon.desktop.interface gtk-theme 'Adapta-Nokto'
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Grey'

gsettings set org.cinnamon.desktop.sound volume-sound-enabled false
gsettings set org.cinnamon.desktop.sound event-sounds false

gsettings set org.nemo.desktop computer-icon-visible false
gsettings set org.nemo.desktop home-icon-visible false
gsettings set org.nemo.desktop trash-icon-visible false
gsettings set org.nemo.desktop network-icon-visible false
gsettings set org.nemo.desktop volumes-visible false

gsettings set org.cinnamon.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.cinnamon alttab-switcher-style 'icons+preview'
gsettings set org.cinnamon panels-autohide "['1,true']"
gsettings set org.cinnamon panels-height "['1,30']"
gsettings set org.cinnamon startup-animation false

#######################################
###     SET UP GIT                  ###
#######################################

git config --global user.email "teobouvard@gmail.com"
git config --global user.name "Téo Bouvard"
git config --global credential.helper store
git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
success "git is set up" 

#######################################
###     SYMLINKS                    ###
#######################################

ln -s ./tmux.conf $HOME/.tmux.conf
ln -s ./zshrc $HOME/.zshrc
