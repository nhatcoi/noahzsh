# =============================================================================
# NoahZSH - Professional ZSH Configuration
# =============================================================================
# 
# This is a modular ZSH configuration designed for:
# - Easy maintenance and customization
# - Cross-platform compatibility
# - Professional development workflow
#
# Installation: curl -fsSL https://raw.githubusercontent.com/nhatcoi/noahzsh/main/bootstrap.sh | bash
# Repository: https://github.com/nhatcoi/noahzsh
# =============================================================================

# =============================================================================
# Environment Setup
# =============================================================================

# Set custom directory
export NOAHZSH_DIR="$HOME/noahzsh"
export ZSH_CUSTOM="$NOAHZSH_DIR/zsh/custom"

# Add local binaries to PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# =============================================================================
# Load Configuration Modules
# =============================================================================

# Load Oh My Zsh configuration
[[ -f "$ZSH_CUSTOM/plugins/oh-my-zsh.zsh" ]] && source "$ZSH_CUSTOM/plugins/oh-my-zsh.zsh"

# Load autosuggestions configuration
[[ -f "$ZSH_CUSTOM/plugins/autosuggestions.zsh" ]] && source "$ZSH_CUSTOM/plugins/autosuggestions.zsh"

# Load custom exports
[[ -f "$ZSH_CUSTOM/export.zsh" ]] && source "$ZSH_CUSTOM/export.zsh"

# Load custom aliases
[[ -f "$ZSH_CUSTOM/aliases.zsh" ]] && source "$ZSH_CUSTOM/aliases.zsh"

# Load NoahZSH command line tool
[[ -f "$ZSH_CUSTOM/functions/nsh.zsh" ]] && source "$ZSH_CUSTOM/functions/nsh.zsh"

# Load welcome banner plugin
[[ -f "$ZSH_CUSTOM/plugins/welcome-banner.zsh" ]] && source "$ZSH_CUSTOM/plugins/welcome-banner.zsh"

# =============================================================================
# Welcome Message (Simple fallback)
# =============================================================================

# Function to center text
center_text() {
    local text="$1"
    local width=$(tput cols 2>/dev/null || echo 80)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%*s%s\n" $padding "" "$text"
}

# Show simple welcome message only if welcome banner plugin is not loaded
if [[ $- == *i* ]] && [[ -z "$NOAHZSH_WELCOME_BANNER_LOADED" ]]; then
    echo ""
    center_text "NoahZSH is ready! 🚀"
    center_text "Custom directory: $ZSH_CUSTOM"
    echo ""
fi