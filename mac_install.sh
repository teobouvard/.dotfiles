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
###     INSTALL ZSH SHELL           ###
#######################################

if [[ -d $HOME/.oh-my-zsh ]]; then
	git pull --allow-unrelated-histories $HOME/.oh-my-zsh > /dev/null
	success "Oh My Zsh updated"
else
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh > /dev/null
	success "Oh My Zsh installed"
fi

chsh -s $(which zsh)
success "switched default shell"

