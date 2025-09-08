#!/bin/bash

# =============================================================================
# Image Viewers Installer for NoahZSH Background
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command_exists apt-get; then
            echo "ubuntu"
        elif command_exists yum; then
            echo "centos"
        elif command_exists pacman; then
            echo "arch"
        else
            echo "linux"
        fi
    else
        echo "unknown"
    fi
}

# Install image viewers
install_image_viewers() {
    local os=$(detect_os)
    
    print_status "Detected OS: $os"
    print_status "Installing image viewers for background display..."
    
    case $os in
        "macos")
            if ! command_exists brew; then
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            
            # Install imgcat (iTerm2)
            if ! command_exists imgcat; then
                print_status "Installing imgcat for iTerm2..."
                # imgcat comes with iTerm2, just check if iTerm2 is installed
                if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
                    print_success "iTerm2 detected - imgcat should be available"
                else
                    print_warning "iTerm2 not detected. Install iTerm2 for best image support."
                fi
            else
                print_success "imgcat already available"
            fi
            
            # Install chafa
            if ! command_exists chafa; then
                print_status "Installing chafa..."
                brew install chafa
                print_success "chafa installed"
            else
                print_success "chafa already installed"
            fi
            
            # Install catimg
            if ! command_exists catimg; then
                print_status "Installing catimg..."
                brew install catimg
                print_success "catimg installed"
            else
                print_success "catimg already installed"
            fi
            ;;
            
        "ubuntu"|"debian")
            print_status "Installing image viewers for Ubuntu/Debian..."
            
            # Update package list
            sudo apt update
            
            # Install chafa
            if ! command_exists chafa; then
                print_status "Installing chafa..."
                sudo apt install -y chafa
                print_success "chafa installed"
            else
                print_success "chafa already installed"
            fi
            
            # Install catimg
            if ! command_exists catimg; then
                print_status "Installing catimg..."
                sudo apt install -y catimg
                print_success "catimg installed"
            else
                print_success "catimg already installed"
            fi
            
            # Install viu
            if ! command_exists viu; then
                print_status "Installing viu..."
                sudo apt install -y viu
                print_success "viu installed"
            else
                print_success "viu already installed"
            fi
            ;;
            
        "centos"|"rhel"|"fedora")
            print_status "Installing image viewers for CentOS/RHEL/Fedora..."
            
            # Install chafa
            if ! command_exists chafa; then
                print_status "Installing chafa..."
                sudo yum install -y chafa
                print_success "chafa installed"
            else
                print_success "chafa already installed"
            fi
            
            # Install catimg
            if ! command_exists catimg; then
                print_status "Installing catimg..."
                sudo yum install -y catimg
                print_success "catimg installed"
            else
                print_success "catimg already installed"
            fi
            ;;
            
        "arch")
            print_status "Installing image viewers for Arch Linux..."
            
            # Install chafa
            if ! command_exists chafa; then
                print_status "Installing chafa..."
                sudo pacman -S --noconfirm chafa
                print_success "chafa installed"
            else
                print_success "chafa already installed"
            fi
            
            # Install catimg
            if ! command_exists catimg; then
                print_status "Installing catimg..."
                sudo pacman -S --noconfirm catimg
                print_success "catimg installed"
            else
                print_success "catimg already installed"
            fi
            ;;
            
        *)
            print_error "Unsupported OS: $os"
            echo ""
            echo "Please install one of the following image viewers manually:"
            echo "  • imgcat (iTerm2 only)"
            echo "  • chafa - Terminal image viewer"
            echo "  • catimg - Cat image viewer"
            echo "  • viu - Terminal image viewer"
            exit 1
            ;;
    esac
}

# Create sample background image
create_sample_background() {
    local bg_path="$NOAHZSH_DIR/background.jpg"
    
    if [[ ! -f "$bg_path" ]]; then
        print_status "Creating sample background image..."
        
        # Create a simple colored background using ImageMagick if available
        if command_exists convert; then
            convert -size 800x600 gradient:blue-purple "$bg_path"
            print_success "Sample background image created: $bg_path"
        else
            print_warning "ImageMagick not found. Please add your own background.jpg to $NOAHZSH_DIR/"
            echo ""
            echo "💡 You can:"
            echo "  1. Copy any .jpg image to $bg_path"
            echo "  2. Or install ImageMagick: brew install imagemagick"
        fi
    else
        print_success "Background image already exists: $bg_path"
    fi
}

# Main function
main() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              NoahZSH Image Viewers Installer                ║"
    echo "║              Background Image Support                       ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    install_image_viewers
    create_sample_background
    
    echo ""
    print_success "Image viewers installation complete!"
    echo ""
    echo "🎨 Background image support:"
    echo "  • Place your background.jpg in: $NOAHZSH_DIR/"
    echo "  • Supported formats: JPG, PNG, GIF"
    echo "  • Recommended size: 800x600 or similar"
    echo ""
    echo "🖼️  Available image viewers:"
    if command_exists imgcat; then echo "  ✅ imgcat (iTerm2)"; fi
    if command_exists chafa; then echo "  ✅ chafa"; fi
    if command_exists catimg; then echo "  ✅ catimg"; fi
    if command_exists viu; then echo "  ✅ viu"; fi
    echo ""
    echo "💡 Restart your terminal to see the background image!"
}

# Run main function
main "$@"

