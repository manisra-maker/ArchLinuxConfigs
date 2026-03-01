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
  python-pillow "Image proccessing tool used by kitty" on
  pavucontrol "pavucontrol" on
  fastfetch "fastfetch" on
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
  pipx install pywal16
else
  echo "[+] pywal16-colors already installed."
fi

# install pywalfox
if ! pipx list | grep -q pywalfox; then
  echo "[+] Installing pywalfox..."
  pipx install --index-url https://test.pypi.org/simple/ pywalfox==2.8.0rc1
  pywalfox install
else
  echo "[+] pywalfox already installed."
fi

CONFIG_SOURCE="/home/manish/ArchLinuxConfigs/configs/"
CONFIG_DEST="$HOME/.config"

echo
echo "[+] Copying configuration files..."

if [[ ! -d "$CONFIG_SOURCE" ]]; then
  echo "Config source directory not found: $CONFIG_SOURCE"
  exit 1
fi

for item in "$CONFIG_SOURCE"/*; do
  name=$(basename "$item")
  dest_path="$CONFIG_DEST/$name"

  if [[ -e "$dest_path" ]]; then
    read -p "Config '$name' exists. Replace it? (y/n): " replace
    if [[ "$replace" == "y" ]]; then
      rm -rf "$dest_path"
      cp -r "$item" "$CONFIG_DEST/"
      echo "Replaced $name"
    else
      echo "Skipped $name"
    fi
  else
    cp -r "$item" "$CONFIG_DEST/"
    echo "Copied $name"
  fi
done

# copy desktop files
DESKTOP_SOURCE="./desktop_files"
DESKTOP_DEST="$HOME/.local/share/applications"

echo
echo "[+] Copying desktop files..."

if [[ -d "$DESKTOP_SOURCE" ]]; then
  mkdir -p "$DESKTOP_DEST"
  cp -r "$DESKTOP_SOURCE"/* "$DESKTOP_DEST"/
  echo "Desktop files copied."
else
  echo "No desktop_files directory found at $DESKTOP_SOURCE"
fi

echo
echo "Let's configure zsh shall we ?"
echo

zsh_banner='
 _____  _____ __  __  __________  _   __________________ ____________  _________   __
/__  / / ___// / / / / ____/ __ \/ | / / ____/  _/ ____//_  __/  _/  |/  / ____/  / /
  / /  \__ \/ /_/ / / /   / / / /  |/ / /_   / // / __   / /  / // /|_/ / __/    / / 
 / /_____/ / __  / / /___/ /_/ / /|  / __/ _/ // /_/ /  / / _/ // /  / / /___   /_/  
/____/____/_/ /_/  \____/\____/_/ |_/_/   /___/\____/  /_/ /___/_/  /_/_____/  (_)    
'

echo "$zsh_banner"
echo

# install zsh + git + wget (needed for oh-my-zsh)
sudo pacman -S --needed --noconfirm zsh git wget

# create empty .zshrc if not exists
if [[ ! -f "$HOME/.zshrc" ]]; then
  touch "$HOME/.zshrc"
fi

# install oh-my-zsh (unattended)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "[+] Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "[+] Oh My Zsh already installed."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# install zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  echo "[+] Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# install zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  echo "[+] Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# install powerlevel10k
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  echo "[+] Installing powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# configure plugins + theme
echo "[+] Configuring .zshrc..."

# set theme
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"

# set plugins cleanly
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$HOME/.zshrc"

echo "[+] Zsh setup complete. Restart terminal or run: exec zsh"

aur_banner='
    ___   __  ______      _____   ________________    __    __    __________      __
   /   | / / / / __ \    /  _/ | / / ___/_  __/   |  / /   / /   / ____/ __ \    / /
  / /| |/ / / / /_/ /    / //  |/ /\__ \ / / / /| | / /   / /   / __/ / /_/ /   / / 
 / ___ / /_/ / _, _/   _/ // /|  /___/ // / / ___ |/ /___/ /___/ /___/ _, _/   /_/  
/_/  |_\____/_/ |_|   /___/_/ |_//____//_/ /_/  |_/_____/_____/_____/_/ |_|   (_)    
'

echo
echo "$aur_banner"
echo

# ask for AUR helper installation
read -p "Do you want to install AUR helper (yay)? (y/n): " install_aur

if [[ "$install_aur" == "y" ]]; then
  if ! command -v yay &>/dev/null; then
    echo "[+] Installing yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
  else
    echo "[+] yay already installed."
  fi
else
  echo "Skipping AUR installation."
fi

echo
echo "[+] Installation complete."
echo "Open a new terminal to start using zsh."

echo "Done."
