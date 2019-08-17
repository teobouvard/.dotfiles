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
###     DESKTOP APPEARANCE          ###
#######################################

mkdir -p $HOME/Pictures/Wallpapers/
sudo wget -qO $HOME/Pictures/Wallpapers/dragon.jpg https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg
sudo wget -qO $HOME/Pictures/Wallpapers/flow.jpg https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "~/Pictures/Wallpapers/dragon.jpg" '