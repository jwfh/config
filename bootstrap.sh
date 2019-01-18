#!/usr/bin/env sh

# Symlink our custom ZSH theme into the OMZ directory
ln -s $HOME/.dotfiles/.oh-my-zsh-addons/xxf/themes/xxf.zsh-theme $HOME/.dotfiles/.oh-my-zsh/custom/themes/xxf.zsh-theme

# Add custom wallpaper
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$HOME/.dotfiles/images/coffee.jpg'";
killall Dock;

# Install gem
TMPA=$(mktemp -d)
git clone --recurse https://github.com/rubygems/rubygems $(TMPA)
cd $(TMPA)
sudo ruby setup.rb

# Install Jekyll static site generator
gem install jekyll

# Install HomeBrew - The missing package manager for macOS
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the things that Apple didn't
brew install wget npm fish 
