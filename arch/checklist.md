## Keyboard layout

* loadkeys fr (not mac, but good enough)

## Networking

* dhcpcd
* ping google.com

## Formatting disks

* fdisk -l
* cfdisk : esp + / + swap (opt)
* mkfs.fat -F32 for efi 
* mkfs.ext4 for / 
* mkswap for swap partition 

## Mounting

* mkdir -p /mnt/efi
* mount / on /mnt and esp on /mnt/efi

## Bootstrapping

* vim /etc/pacman.d/mirrorlist and put close servers at the top
* pacstrap /mnt base base-devel linux linux-firmware vim zsh dhcpcd man-db man-pages
* genfstab -U /mnt >> /mnt/etc/fstab

## System setup

* arch-chroot /mnt
* timedatectl set-timezone (Europe/Paris)
* hwclock --systohc
* [follow the guide](https://wiki.archlinux.org/index.php/installation_guide)

## Bootloader

* pacman -S efibootmgr grub os-prober (intel-ucode | amd-ucode)
* mount other esp to /mnt and run os-prober
* grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB
* grub-mkconfig -o /boot/grub/grub.cfg

## User

* groupadd sudo
* useradd -m -G sudo -s /bin/zsh user
* passwd user

* export EDITOR=vim
* visudo
* add Defaults editor=/usr/bin/vim
* uncomment sudo line

* login

## Package manager

* sudo pacman -S git
* git clone https://aur.archlinux.org/yay.git
* cd yay && makepkg -si

## Display manager

* sudo pacman -S lightdm
* yay -S lightdm-slick-greeter
* edit /etc/lightdm/lightdm.conf to set lightdm-slick-greeter as greeter-session for all seats
* sudo systemctl enable lightdm
* add /etc/X11/xorg.conf.d/20-keyboard.conf with (so that greeter has the right layout)

```
Section "InputClass"
    Identifier "keyboard"
    MatchIsKeyboard "yes"
    Option "XkbLayout" "fr"
EndSection
```

## Desktop environment

* sudo pacman -S cinnamon file-roller (zip)
* sudo systemctl enable SystemManager
* reboot

## First usable setup

* pacman -S gnome-terminal
* yay -S google-chrome

## Shell setup

* nerd font (hack+meslo) -> unzip + mv /usr/share/fonts/(hack|meslo) + fc-cache
* oh-my-zsh
* powerlevel10k
* gogh color palette (Neutron) + create profile before

## Graphical setup

* cblack theme
* papirus icons
* wallpapers

## Install packages

* pacman -S --needed - < pacman.txt
* yay -S --needed - < yay.txt

## Extensions

* cinnamon maximus

## Applets

* qredshift