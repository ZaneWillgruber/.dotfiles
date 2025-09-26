# Dotfiles

> [!WARNING]
> Bare bones right now and continually being updated

My dotfiles for my Arch and Hyprland system

## Requirements

Make sure you have the following requirements on your system

### Arch Profile

-Desktop
-Hyprland

### Git
```
pacman -S git
```

### Stow
```
pacman -S stow
```

## Installation
Clone repo

```
git clone https://github.com/ZaneWillgruber/.dotfiles.git
cd .dotfiles/config
```

Use stow to create symlinks
```
stow . -t ~
```

Run install.sh
```
cd ..
chmod +x install.sh
./install.sh
```
