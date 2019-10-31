This is a framework I use to set up my personal linux environment. Take a look at the [install script](install.sh) before running it !

## Install
  
  
```shell
cd
dpkg --configure -a
sudo apt-get upgrade 
sudo apt-get -y install git
git clone https://github.com/teobouvard/.dotfiles.git
cd .dotfiles
./install.sh
```

## TODO
* create terminal profile 
* change gTile hotkey  
* add ranger image and pdf preview

# Configuration checklist
* SSH
* ufw
* Pi-hole
