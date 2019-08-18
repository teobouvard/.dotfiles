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
###     OS DETECTION                ###
#######################################

case "$OSTYPE" in

    darwin*)  
        success "detected OS : macOS" 
        source ./mac_install.sh
    ;; 

    linux*)
        success "detected OS : Linux"
        source ./linux_install.sh
    ;;

    *)
        error "unknown OS : $OSTYPE"
        exit
    ;;

esac

#######################################
###     GENERATE SSH KEYS           ###
#######################################

if [[ -f "$HOME/.ssh/id_rsa" ]]; then
	success "existing SSH keys"
else
	info "generating SSH keys"
	ssh-keygen -t rsa
	success "SSH key created"
fi

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
	success "zsh is already the default shell"
else
	chsh -s $(which zsh)
	success "switched default shell to zsh"
fi

ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc

#######################################
###     SET UP GIT                  ###
#######################################

git config --global user.email "teobouvard@gmail.com"
git config --global user.name "Téo Bouvard"
git config --global credential.helper store
git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
success "git settings updated" 

#######################################
###     SET UP MUTT                 ###
#######################################

mkdir -p $HOME/.mutt/cache
ln -sf $HOME/.dotfiles/.muttrc $HOME/.muttrc
success "mutt settings updated"

#######################################
###     COLOR PALETTE               ###
#######################################

# Neutron (103)
info "change color palette ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) bash -c  "$(wget -qO- https://git.io/vQgMr)"; break;;
        No  ) break;;
    esac
done