#!/bin/bash

# =============================================================================
# Dependencies Installer for NoahZSH Welcome Banner
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

# Install figlet and lolcat
install_dependencies() {
    local os=$(detect_os)
    
    print_status "Detected OS: $os"
    print_status "Installing welcome banner dependencies..."
    
    case $os in
        "macos")
            if ! command_exists brew; then
                print_error "Homebrew not found. Please install Homebrew first."
                echo "Install Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
                exit 1
            fi
            
            # Install figlet
            if ! command_exists figlet; then
                print_status "Installing figlet..."
                brew install figlet
                print_success "figlet installed"
            else
                print_success "figlet already installed"
            fi
            
            # Install lolcat
            if ! command_exists lolcat; then
                print_status "Installing lolcat..."
                brew install lolcat
                print_success "lolcat installed"
            else
                print_success "lolcat already installed"
            fi
            
            # Install figlet fonts
            if [[ ! -d "/opt/homebrew/share/figlet" ]]; then
                print_status "Installing figlet fonts..."
                brew install figlet-fonts
                print_success "figlet fonts installed"
            else
                print_success "figlet fonts already available"
            fi
            ;;
            
        "ubuntu"|"debian")
            print_status "Installing dependencies for Ubuntu/Debian..."
            
            # Update package list
            sudo apt update
            
            # Install figlet
            if ! command_exists figlet; then
                print_status "Installing figlet..."
                sudo apt install -y figlet
                print_success "figlet installed"
            else
                print_success "figlet already installed"
            fi
            
            # Install lolcat
            if ! command_exists lolcat; then
                print_status "Installing lolcat..."
                sudo apt install -y lolcat
                print_success "lolcat installed"
            else
                print_success "lolcat already installed"
            fi
            ;;
            
        "centos"|"rhel"|"fedora")
            print_status "Installing dependencies for CentOS/RHEL/Fedora..."
            
            # Install figlet
            if ! command_exists figlet; then
                print_status "Installing figlet..."
                sudo yum install -y figlet
                print_success "figlet installed"
            else
                print_success "figlet already installed"
            fi
            
            # Install lolcat
            if ! command_exists lolcat; then
                print_status "Installing lolcat..."
                sudo yum install -y lolcat
                print_success "lolcat installed"
            else
                print_success "lolcat already installed"
            fi
            ;;
            
        "arch")
            print_status "Installing dependencies for Arch Linux..."
            
            # Install figlet
            if ! command_exists figlet; then
                print_status "Installing figlet..."
                sudo pacman -S --noconfirm figlet
                print_success "figlet installed"
            else
                print_success "figlet already installed"
            fi
            
            # Install lolcat
            if ! command_exists lolcat; then
                print_status "Installing lolcat..."
                sudo pacman -S --noconfirm lolcat
                print_success "lolcat installed"
            else
                print_success "lolcat already installed"
            fi
            ;;
            
        *)
            print_error "Unsupported OS: $os"
            echo ""
            echo "Please install the following dependencies manually:"
            echo "  • figlet - ASCII art generator"
            echo "  • lolcat - Rainbow colors for text"
            echo ""
            echo "Visit: https://github.com/nhatcoi/noahzsh for more information"
            exit 1
            ;;
    esac
}

# Test installation
test_installation() {
    print_status "Testing installation..."
    
    if command_exists figlet; then
        print_success "figlet is working"
    else
        print_error "figlet not found"
    fi
    
    if command_exists lolcat; then
        print_success "lolcat is working"
    else
        print_error "lolcat not found"
    fi
    
    # Test figlet with lolcat
    if command_exists figlet && command_exists lolcat; then
        print_status "Testing figlet + lolcat combination..."
        echo "NoahZSH" | figlet -f slant | lolcat
        print_success "Welcome banner dependencies are working!"
    fi
}

# Main function
main() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              NoahZSH Dependencies Installer                 ║"
    echo "║              Welcome Banner Support                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    install_dependencies
    test_installation
    
    echo ""
    print_success "Dependencies installation complete!"
    echo ""
    echo "🎨 Welcome banner features:"
    echo "  • ASCII art with figlet"
    echo "  • Rainbow colors with lolcat"
    echo "  • Centered text display"
    echo "  • Background image support"
    echo ""
    echo "💡 Restart your terminal to see the welcome banner!"
}

# Run main function
main "$@"

