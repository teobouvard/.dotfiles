#!/bin/bash

#######################################
###     INSTALL HOMEBREW            ###
#######################################

if test ! $(which brew); then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	success "brew installed"
else
	info "brew already installed"
fi

#######################################
###     INSTALL PACKAGES            ###
#######################################

brew cask install $(grep -vE "^\s*#" cask_packages  | tr "\n" " ") > /dev/null
brew install $(grep -vE "^\s*#" brew_packages  | tr "\n" " ") > /dev/null
success "packages installed"

#######################################
###     INSTALL ZSH SHELL           ###
#######################################

if [[ -d $HOME/.oh-my-zsh ]]; then
	git -C $HOME/.oh-my-zsh pull > /dev/null
	success "Oh My Zsh updated"
else
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh > /dev/null
	success "Oh My Zsh installed"
fi

if [[ $SHELL = "$(which zsh)" ]]; then
	info "zsh is already the default shell"
else
	chsh -s $(which zsh)
	success "switched default shell to zsh"
fi

#######################################
###     DESKTOP APPEARANCE          ###
#######################################

mkdir -p $HOME/Pictures/Wallpapers/
sudo wget -qO $HOME/Pictures/Wallpapers/dragon.jpg https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg
sudo wget -qO $HOME/Pictures/Wallpapers/flow.jpg https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg