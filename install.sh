#!/bin/bash

PACKAGES=(
	"spotify-launcher"
	"ttf-nerd-fonts-symbols"
	"ttf-jetbrains-mono-nerd"
	"neofetch"
	"hyprpaper"
	"playerctl"
	"discord"
	"waybar"
	"otf-font-awesome"
	"cliphist"
	"pygobject" #to make waybar cutom/media work
	"ghostty"
	"zen-browser-bin"
	"libastal-meta"
	"aylurs-gtk-shell-git"
	"gvfs"
	"gvfs-smb"
	"gvfs-goa"
	"libsoup"
	"gdk-pixbuf"
	"networkmanager"
	"gcc"
	"make"
	"git"
	"ripgrep"
	"fd"
	"unzip"
	"neovim"
	"wl-clipboard"
)

echo "Updating system..."
sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
	echo "yay is not installed. Installing yay..."
	sudo pacman -S --needed base-devel git
	cd ~
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
else
	echo "yay is already installed."
fi

yay -Syu --noconfirm

for package in "${PACKAGES[@]}"; do
	if yay -Qi "$package" &> /dev/null; then
		echo "$package is already installed. Skipping..."
	else
		echo "$package is not installed. Installing..."
		yay -S "$package" --noconfirm --needed
	fi
done

if id -nG zane | grep -qw input; then
	echo "User zane is already in group input"
else
	sudo usermod -a -G input zane
	if [[ $? -eq 0 ]]; then
		echo "User zane has been added to group input"
	else
		echo "Error: Failed to add user 'zane' to group 'input'"
	fi
fi
