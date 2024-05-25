#!/bin/bash

# Description: Script to install ZSH, Oh My Zsh, Powerlevel10k and some plugins

echo "This script will install ZSH, Oh My Zsh, Powerlevel10k and some plugins, and set ZSH as the default shell"
echo "First, you need to install this fonts, which are required by Powerlevel10k:"
echo "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
echo "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
echo "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
echo "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
echo "After installing the fonts, you need to set them in your terminal emulator\n"

echo "Updating package list"
sudo -v

echo "Updating package list"
sudo apt update

echo "Upgrading packages"
sudo apt upgrade -y

echo "Removing previous versions of ZSH, Oh My Zsh and Powerlevel10k"
sudo apt-get --purge remove zsh -y
rm -rf ~/.oh-my-zsh
rm -rf ~/.zshrc
rm -rf ~/.p10k.zsh


echo "Installing ZSH"
sudo apt install zsh -y

echo "Installing Oh My Zsh"
export RUNZSH=no  # No cambiar automáticamente al shell Zsh
export CHSH=no  # No cambiar automáticamente el shell predeterminado
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Enabling Powerlevel10k"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

echo "Installing ZSH plugins..."
echo "Installing ZSH autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc

echo "Setting ZSH as default shell"
sudo chsh -s $(which zsh)

echo "Copying .p10k.zsh to home directory"
cp .p10k.zsh ~/.p10k.zsh

echo "Done! Executing ZSH..."
zsh