#!/bin/bash

clear

banner='
                                                                                                                    
                                                                                                                    
▄████▄ ▄▄▄▄   ▄▄▄▄ ▄▄ ▄▄   ▄█████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ ▄▄  ▄▄▄▄   ██ ▄▄  ▄▄  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄  ▄▄    ▄▄    ▄▄▄▄▄ ▄▄▄▄  
██▄▄██ ██▄█▄ ██▀▀▀ ██▄██   ██     ██▀██ ███▄██ ██▄▄  ██ ██ ▄▄   ██ ███▄██ ███▄▄   ██  ██▀██ ██    ██    ██▄▄  ██▄█▄ 
██  ██ ██ ██ ▀████ ██ ██   ▀█████ ▀███▀ ██ ▀██ ██    ██ ▀███▀   ██ ██ ▀██ ▄▄██▀   ██  ██▀██ ██▄▄▄ ██▄▄▄ ██▄▄▄ ██ ██ 
                                                                                                                    
'

colors=(196 202 226 82 51 21 93 201)

i=0
while IFS= read -r line; do
  for ((j=0; j<${#line}; j++)); do
    char="${line:$j:1}"

    if [[ "$char" == " " ]]; then
      printf " "
    else
      color=${colors[$((i % ${#colors[@]}))]}
      printf "\e[38;5;%sm%s\e[0m" "$color" "$char"
      ((i++))
    fi
  done
  printf "\n"
done <<< "$banner"

echo

set -e

read -p "Do you want to update the system first? (y/n): " update
if [[ $update == "y" ]]; then
  echo "[+] Updating system..."
  sudo pacman -Syu --noconfirm
fi

# ensure dialog exists
if ! command -v dialog &>/dev/null; then
  echo "[+] Installing dialog..."
  sudo pacman -S --needed --noconfirm dialog
fi

options=(
  hyprland "Wayland compositor" on
  hyprlock "Screen locker" on
  hypridle "Idle daemon" on
  waybar "Status bar" on
  rofi-wayland "App launcher" on
  kitty "Terminal" on
  hyprshot "Screenshot utility" on
  xdg-desktop-portal-hyprland "Portal backend" on
  thunar "File manager" on
  neovim "Text editor" on
  nodejs "Node runtime" on
  npm "Node package manager" on
  deno "Deno runtime" on
  python-pipx "Pipx for pywal16" on
  firefox "Web browser" on
)

choices=$(dialog --clear \
  --backtitle "Arch Config Installer" \
  --title "Select Packages" \
  --checklist "Use SPACE to select:" 20 70 15 \
  "${options[@]}" \
  2>&1 >/dev/tty)

clear

if [[ -z "$choices" ]]; then
  echo "No packages selected. Aborting."
  exit 0
fi

echo "[+] Installing selected packages..."
sudo pacman -S --needed --noconfirm $choices

# ensure pipx path is set
pipx ensurepath

# install pywal16
if ! pipx list | grep -q pywal16-colors; then
  echo "[+] Installing pywal16-colors..."
  pipx install pywal16-colors
else
  echo "[+] pywal16-colors already installed."
fi

echo "Done."
