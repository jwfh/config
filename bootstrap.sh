#!/usr/bin/env sh

ln -s $HOME/.dotfiles/.oh-my-zsh-addons/xxf/themes/xxf.zsh-theme $HOME/.dotfiles/.oh-my-zsh/custom/themes/xxf.zsh-theme

# Add custom wallpaper
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$HOME/.dotfiles/images/coffee.jpg'";
killall Dock;

