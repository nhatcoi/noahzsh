#!/bin/bash

# Màu sắc cho output
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starting NoahZSH installation...${NC}"

# 1. Clone repository
if [ ! -d "$HOME/noahzsh" ]; then
    echo "Cloning NoahZSH repository..."
    git clone https://github.com/nhatcoi/noahzsh.git "$HOME/noahzsh"
fi

# 2. Install Oh My Zsh if not exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Install zsh-autosuggestions plugin
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
PLUGIN_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"

if [ ! -d "$PLUGIN_DIR" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
fi

# 4. Backup existing .zshrc if exists
if [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# 5. Create symbolic link for .zshrc
echo "Setting up configuration..."
ln -sf "$HOME/noahzsh/zsh/.zshrc" "$HOME/.zshrc"

# 6. Source the new configuration
echo -e "${GREEN}Installation complete! Reloading shell configuration...${NC}"
source "$HOME/.zshrc"

echo -e "${GREEN}NoahZSH has been installed successfully!${NC}"
echo "Please restart your terminal for all changes to take effect."
