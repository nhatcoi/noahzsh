#!/bin/bash

# =============================================================================
# NoahZSH Bootstrap Script
# =============================================================================
# 
# This script installs and configures NoahZSH - a professional ZSH configuration
# for developers who want a clean, maintainable, and feature-rich shell setup.
#
# Usage: curl -fsSL https://raw.githubusercontent.com/nhatcoi/noahzsh/main/bootstrap.sh | bash
# =============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/nhatcoi/noahzsh.git"
INSTALL_DIR="$HOME/noahzsh"
ZSH_CUSTOM="$INSTALL_DIR/zsh/custom"

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Main installation function
main() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    NoahZSH Installer                        ║"
    echo "║              Professional ZSH Configuration                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Check prerequisites
    print_status "Checking prerequisites..."
    
    if ! command_exists git; then
        print_error "Git is required but not installed. Please install Git first."
        exit 1
    fi
    
    if ! command_exists zsh; then
        print_error "Zsh is required but not installed. Please install Zsh first."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
    
    # Clone or update repository
    if [ -d "$INSTALL_DIR" ]; then
        print_status "Updating existing NoahZSH installation..."
        cd "$INSTALL_DIR"
        git pull origin main
        print_success "NoahZSH updated successfully"
    else
        print_status "Cloning NoahZSH repository..."
        git clone "$REPO_URL" "$INSTALL_DIR"
        print_success "NoahZSH cloned successfully"
    fi
    
    # Install Oh My Zsh if not exists
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_status "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed successfully"
    else
        print_success "Oh My Zsh already installed"
    fi
    
    # Install zsh-autosuggestions plugin
    PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    if [ ! -d "$PLUGIN_DIR" ]; then
        print_status "Installing zsh-autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
        print_success "zsh-autosuggestions plugin installed"
    else
        print_success "zsh-autosuggestions plugin already installed"
    fi
    
    # Backup existing .zshrc if exists
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        print_status "Backing up existing .zshrc..."
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        print_success "Existing .zshrc backed up"
    fi
    
    # Create symbolic link for .zshrc
    print_status "Setting up configuration..."
    ln -sf "$INSTALL_DIR/zsh/.zshrc" "$HOME/.zshrc"
    print_success "Configuration linked successfully"
    
    # Set zsh as default shell (if not already)
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_status "Setting zsh as default shell..."
        if command_exists chsh; then
            chsh -s "$(which zsh)"
            print_success "Zsh set as default shell"
        else
            print_warning "Could not set zsh as default shell. Please run: chsh -s \$(which zsh)"
        fi
    fi
    
    # Final success message
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                Installation Complete!                       ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    print_success "NoahZSH has been installed successfully!"
    echo ""
    echo "📁 Installation directory: $INSTALL_DIR"
    echo "🔧 Configuration directory: $ZSH_CUSTOM"
    echo "📝 Main config file: $HOME/.zshrc"
    echo ""
    echo " To start using NoahZSH:"
    echo "   1. Restart your terminal, or"
    echo "   2. Run: source ~/.zshrc"
    echo ""
    echo "💡 Useful commands:"
    echo "   • Edit config: code $ZSH_CUSTOM"
    echo "   • View aliases: alias"
    echo "   • Reload config: source ~/.zshrc"
    echo ""
    echo "📚 Documentation: https://github.com/nhatcoi/noahzsh"
}

# Run main function
main "$@"