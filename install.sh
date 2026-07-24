#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=(fastfetch hyprland waybar rofi kitty cava git curl)

echo ":: Installing packages..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo ":: Linking dotfiles..."
mkdir -p "$HOME/.config"

for config in "$DOTFILES_DIR"/*; do
    config_name=$(basename "$config")

    case "$config_name" in
        "install.sh"|"README.md"|".git"|".gitignore"|".bashrc")
            continue
            ;;
        *)
            echo "-> Linking: $config_name"
            rm -rf "$HOME/.config/$config_name" 2>/dev/null
            ln -sf "$config" "$HOME/.config/$config_name"
            ;;
    esac
done

echo ":: Setup complete."

ln -sf ~/dotfiles/fastfetch ~/.config/fastfetch
ln -sf ~/dotfiles/.bashrc ~/.bashrc
