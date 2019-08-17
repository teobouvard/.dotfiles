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

sudo wget -qO /Library/User\ Pictures/dragon.jpg https://www.nasa.gov/sites/default/files/thumbnails/image/iss058e027197.jpg
sudo wget -qO /Library/User\ Pictures/flow.jpg https://dubaiastronomy.com/wp-content/uploads/2019/04/art-artistic-background-1020315.jpg

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/User Pictures/dragon.jpg" '
success "changed desktop image"

sudo dscl . delete /Users/$(whoami) JPEGPhoto
sudo dscl . create /Users/$(whoami) Picture "/Library/User Pictures/flow.jpg"
success "changed user image"