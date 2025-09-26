#!/bin/bash

PACKAGES=(
	"ttf-nerd-fonts-symbols"
	"ttf-jetbrains-mono-nerd"
	"otf-font-awesome"
	"gcc"
	"make"
	"git"
	"ripgrep"
	"fd"
	"unzip"
	"neovim"
	"tmux"
	"fzf"
	"bat"
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

# install tmux package manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Cloning tmux plugin manager (tpm)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "tmux plugin manager (tpm) is already installed."
fi
