#!/bin/bash

PACKAGES=(
	"spotify-launcher"
	"ttf-nerd-fonts-symbols"
	"neofetch"
	"hyprpaper"
	"playerctl"
	"discord"
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
		yay -S "$package" --noconfirm
	fi
done
