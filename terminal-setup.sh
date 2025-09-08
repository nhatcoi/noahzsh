#!/bin/bash

# =============================================================================
# Terminal Setup Script for NoahZSH
# =============================================================================

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 NoahZSH Terminal Setup${NC}"
echo ""

# Detect terminal application
detect_terminal() {
    if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        echo "iTerm2"
    elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
        echo "Terminal"
    elif [[ "$TERM_PROGRAM" == "vscode" ]]; then
        echo "VS Code"
    else
        echo "Unknown"
    fi
}

# Setup terminal size
setup_terminal_size() {
    local terminal=$(detect_terminal)
    
    echo -e "${BLUE}📱 Detected terminal: $terminal${NC}"
    echo ""
    
    case $terminal in
        "iTerm2")
            echo -e "${YELLOW}💡 For iTerm2:${NC}"
            echo "  1. Go to iTerm2 > Preferences > Profiles > Window"
            echo "  2. Set Columns: 120, Rows: 40"
            echo "  3. Or use: Cmd + I > Window > Columns: 120, Rows: 40"
            ;;
        "Terminal")
            echo -e "${YELLOW}💡 For Terminal.app:${NC}"
            echo "  1. Go to Terminal > Preferences > Profiles > Window"
            echo "  2. Set Columns: 120, Rows: 40"
            echo "  3. Or use: Cmd + T to open new tab with default size"
            ;;
        "VS Code")
            echo -e "${YELLOW}💡 For VS Code Terminal:${NC}"
            echo "  1. Go to Settings > Terminal > Integrated"
            echo "  2. Set 'terminal.integrated.fontSize': 14"
            echo "  3. Set 'terminal.integrated.columns': 120"
            ;;
        *)
            echo -e "${YELLOW}💡 General tips:${NC}"
            echo "  • Make terminal window wider (120+ columns)"
            echo "  • Increase height (40+ rows)"
            echo "  • Use full screen for best experience"
            ;;
    esac
}

# Show current terminal size
show_current_size() {
    local cols=$(tput cols 2>/dev/null || echo "unknown")
    local rows=$(tput lines 2>/dev/null || echo "unknown")
    
    echo -e "${BLUE}📏 Current terminal size: ${cols} columns × ${rows} rows${NC}"
    
    if [[ "$cols" -lt 100 ]]; then
        echo -e "${YELLOW}⚠️  Terminal is quite narrow. Consider making it wider for better banner display.${NC}"
    fi
    
    if [[ "$rows" -lt 30 ]]; then
        echo -e "${YELLOW}⚠️  Terminal is quite short. Consider making it taller.${NC}"
    fi
}

# Main function
main() {
    show_current_size
    echo ""
    setup_terminal_size
    echo ""
    echo -e "${GREEN}✅ Terminal setup complete!${NC}"
    echo ""
    echo "🎨 Your welcome banner will look best with:"
    echo "  • 120+ columns width"
    echo "  • 40+ rows height"
    echo "  • Full screen mode"
}

# Run main function
main "$@"

