# ArchLinuxConfigs
My Arch Linux Configs

## What is use 

1. hyprland as my desktop environment 
2. hyprlock to lock desktop
3. Neovim to edit files 
4. I have made a change wallpaper script using swww and pywal 16-bit colors 

Incase you want check this out 

1. <a href="https://github.com/LGFae/swww">Swww</a>
2. <a href="https://www.youtube.com/watch?v=_xKIVzZAaGM">Pywal 16 bit color video</a> 
3. <a href="https://github.com/michaelScopic/Wallpapers">Where i originally got my Wallpapers from</a> 

For Terminal i use 

1. zsh , then run chsh /bin/zsh , create .zshrc thats empty
2. oh my zsh --> sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
3. zsh auto-suggestions --> 

Clone this repository into $ZSH_CUSTOM/plugins (by default ~/.oh-my-zsh/custom/plugins)

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc):

plugins=( 
    # other plugins...
    zsh-autosuggestions
)

4. sh-syntax-highlighting

Since we use oh-my-zsh

Oh-my-zsh

    Clone this repository in oh-my-zsh's plugins directory:

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    Activate the plugin in ~/.zshrc:

    plugins=( [plugins...] zsh-syntax-highlighting)

5. powerlevel 10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

Open ~/.zshrc, find the line that sets ZSH_THEME, and change its value to "powerlevel10k/powerlevel10k".
