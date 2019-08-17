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