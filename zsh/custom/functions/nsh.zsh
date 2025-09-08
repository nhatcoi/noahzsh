# =============================================================================
# NoahZSH Command Line Tool (nsh)
# =============================================================================

# Prevent multiple loading
if [[ -z "$NOAHZSH_NSH_LOADED" ]]; then
    export NOAHZSH_NSH_LOADED=1

# NoahZSH directory
NOAHZSH_DIR="$HOME/noahzsh"
NOAHZSH_CUSTOM="$NOAHZSH_DIR/zsh/custom"

# Main nsh function
nsh() {
    case "$1" in
        --version|-v)
            echo "NoahZSH v1.0.0"
            ;;
            
        --help|-h)
            echo "NoahZSH Command Line Tool"
            echo ""
            echo "Usage: nsh [command]"
            echo ""
            echo "Commands:"
            echo "  --version, -v     Show version information"
            echo "  --help, -h        Show this help message"
            echo "  open              Open configuration directory in editor"
            echo "  save              Reload zsh configuration"
            echo "  docs              Open documentation"
            echo "  alias             Show all available aliases"
            echo "  config            Show current configuration"
            echo "  update            Update NoahZSH to latest version"
            echo "  status            Show installation status"
            echo "  clean             Clean up temporary files"
            echo "  backup            Backup current configuration"
            echo "  restore           Restore from backup"
            echo "  install-deps      Install welcome banner dependencies"
            echo "  terminal-setup    Setup terminal for best banner display"
            echo "  uninstall         Uninstall NoahZSH completely"
            ;;
            
        open)
            if command -v code >/dev/null 2>&1; then
                code "$NOAHZSH_CUSTOM"
                echo "✅ Opened NoahZSH config in VS Code"
            elif command -v vim >/dev/null 2>&1; then
                vim "$NOAHZSH_CUSTOM"
            else
                echo "❌ No editor found. Please install VS Code or Vim"
            fi
            ;;
            
        save|reload)
            source ~/.zshrc
            # echo "✅ NoahZSH configuration reloaded"
            ;;
            
        docs)
            if command -v open >/dev/null 2>&1; then
                open "https://github.com/nhatcoi/noahzsh"
            elif command -v xdg-open >/dev/null 2>&1; then
                xdg-open "https://github.com/nhatcoi/noahzsh"
            else
                echo "📚 Documentation: https://github.com/nhatcoi/noahzsh"
            fi
            ;;
            
        alias)
            echo "📋 Available Aliases:"
            echo ""
            echo "🔧 System:"
            echo "  c          clear"
            echo "  h          history"
            echo "  q          exit"
            echo "  ll         ls -alh"
            echo ""
            echo "📁 Navigation:"
            echo "  ..         cd .."
            echo "  ...        cd ../.."
            echo "  ~          cd ~"
            echo "  -          cd -"
            echo "  p          pwd"
            echo ""
            echo "🔧 Git:"
            echo "  g          git"
            echo "  gs         git status"
            echo "  ga         git add"
            echo "  gcm        git commit -m"
            echo "  gp         git push"
            echo "  gpl        git pull"
            echo "  glog       git log --oneline --decorate --graph"
            echo ""
            echo "🐳 Docker:"
            echo "  d          docker"
            echo "  dc         docker-compose"
            echo "  dps        docker ps"
            echo ""
            echo "📦 NPM:"
            echo "  ni         npm install"
            echo "  nrs        npm run start"
            echo "  nrb        npm run build"
            echo ""
            echo "💡 Type 'alias' to see all aliases"
            ;;
            
        config)
            echo "⚙️  NoahZSH Configuration:"
            echo ""
            echo "📁 Installation: $NOAHZSH_DIR"
            echo "🔧 Custom dir:   $NOAHZSH_CUSTOM"
            echo "📝 Main config:  ~/.zshrc"
            echo "🎨 Theme:        robbyrussell"
            echo "🔌 Plugins:      zsh-autosuggestions"
            echo ""
            echo "📋 Config files:"
            echo "  📁 plugins/"
            echo "    • oh-my-zsh.zsh    - Oh My Zsh settings"
            echo "    • autosuggestions.zsh - Autosuggestions config"
            echo "  📁 functions/"
            echo "    • nsh.zsh          - NoahZSH command line tool"
            echo "  📁 themes/           - Custom themes (empty)"
            echo "  📁 completions/      - Custom completions (empty)"
            echo "  • aliases.zsh        - Custom aliases"
            echo "  • export.zsh         - Environment variables"
            ;;
            
        update)
            echo "🔄 Updating NoahZSH..."
            cd "$NOAHZSH_DIR"
            if git pull origin main; then
                echo "✅ NoahZSH updated successfully"
                echo "💡 Run 'nsh save' to reload configuration"
            else
                echo "❌ Update failed. Please check your internet connection"
            fi
            ;;
            
        status)
            echo "📊 NoahZSH Status:"
            echo ""
            
            # Check installation
            if [[ -d "$NOAHZSH_DIR" ]]; then
                echo "✅ NoahZSH installed: $NOAHZSH_DIR"
            else
                echo "❌ NoahZSH not found"
            fi
            
            # Check .zshrc link
            if [[ -L "$HOME/.zshrc" ]]; then
                echo "✅ .zshrc linked correctly"
            else
                echo "⚠️  .zshrc not linked"
            fi
            
            # Check Oh My Zsh
            if [[ -d "$HOME/.oh-my-zsh" ]]; then
                echo "✅ Oh My Zsh installed"
            else
                echo "❌ Oh My Zsh not found"
            fi
            
            # Check autosuggestions
            if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
                echo "✅ zsh-autosuggestions installed"
            else
                echo "❌ zsh-autosuggestions not found"
            fi
            ;;
            
        clean)
            echo "🧹 Cleaning NoahZSH..."
            
            # Clean backup files
            find "$NOAHZSH_DIR" -name "*.backup" -delete 2>/dev/null
            find "$NOAHZSH_DIR" -name "*.bak" -delete 2>/dev/null
            find "$NOAHZSH_DIR" -name "*.tmp" -delete 2>/dev/null
            
            # Clean .DS_Store files
            find "$NOAHZSH_DIR" -name ".DS_Store" -delete 2>/dev/null
            
            echo "✅ Cleanup completed"
            ;;
            
        backup)
            local backup_dir="$NOAHZSH_DIR/backups"
            local timestamp=$(date +%Y%m%d_%H%M%S)
            local backup_file="$backup_dir/noahzsh_backup_$timestamp.tar.gz"
            
            mkdir -p "$backup_dir"
            
            echo "💾 Creating backup..."
            tar -czf "$backup_file" -C "$NOAHZSH_DIR" zsh/
            
            if [[ -f "$backup_file" ]]; then
                echo "✅ Backup created: $backup_file"
            else
                echo "❌ Backup failed"
            fi
            ;;
            
        restore)
            local backup_dir="$NOAHZSH_DIR/backups"
            
            if [[ ! -d "$backup_dir" ]]; then
                echo "❌ No backup directory found"
                return 1
            fi
            
            echo "📋 Available backups:"
            ls -la "$backup_dir"/*.tar.gz 2>/dev/null || echo "No backups found"
            echo ""
            echo "💡 To restore: tar -xzf $backup_dir/backup_file.tar.gz -C $NOAHZSH_DIR"
            ;;
            
        install-deps)
            echo "🔧 Installing welcome banner dependencies..."
            if [[ -f "$NOAHZSH_DIR/install-dependencies.sh" ]]; then
                chmod +x "$NOAHZSH_DIR/install-dependencies.sh"
                "$NOAHZSH_DIR/install-dependencies.sh"
            else
                echo "❌ Dependencies installer not found"
            fi
            ;;
            
        terminal-setup)
            echo "🖥️  Setting up terminal for best banner display..."
            if [[ -f "$NOAHZSH_DIR/terminal-setup.sh" ]]; then
                chmod +x "$NOAHZSH_DIR/terminal-setup.sh"
                "$NOAHZSH_DIR/terminal-setup.sh"
            else
                echo "❌ Terminal setup script not found"
            fi
            ;;
            
        uninstall)
            echo "⚠️  WARNING: This will completely remove NoahZSH and all related components!"
            echo ""
            echo "This will remove:"
            echo "  • NoahZSH directory: $NOAHZSH_DIR"
            echo "  • Oh My Zsh directory: $HOME/.oh-my-zsh"
            echo "  • .zshrc symbolic link"
            echo "  • All NoahZSH configurations"
            echo "  • All Oh My Zsh plugins and themes"
            echo ""
            echo "This action cannot be undone!"
            echo ""
            
            # Ask for confirmation
            echo -n "Are you sure you want to completely uninstall NoahZSH? (y/N): "
            read response
            echo ""
            
            if [[ $response =~ ^[Yy]$ ]]; then
                echo "🗑️  Uninstalling NoahZSH and all related components..."
                
                # Remove .zshrc link if it points to NoahZSH
                if [[ -L "$HOME/.zshrc" ]] && [[ "$(readlink "$HOME/.zshrc")" == *"noahzsh"* ]]; then
                    rm "$HOME/.zshrc"
                    echo "✅ Removed .zshrc symbolic link"
                fi
                
                # Remove NoahZSH directory
                if [[ -d "$NOAHZSH_DIR" ]]; then
                    rm -rf "$NOAHZSH_DIR"
                    echo "✅ Removed NoahZSH directory"
                fi
                
                # Remove Oh My Zsh directory
                if [[ -d "$HOME/.oh-my-zsh" ]]; then
                    rm -rf "$HOME/.oh-my-zsh"
                    echo "✅ Removed Oh My Zsh directory"
                fi
                
                # Remove zsh history if it exists
                if [[ -f "$HOME/.zsh_history" ]]; then
                    rm "$HOME/.zsh_history"
                    echo "✅ Removed zsh history"
                fi
                
                # Restore original .zshrc if backup exists
                if [[ -f "$HOME/.zshrc.backup" ]]; then
                    mv "$HOME/.zshrc.backup" "$HOME/.zshrc"
                    echo "✅ Restored original .zshrc from backup"
                else
                    # Create a basic .zshrc if no backup exists
                    cat > "$HOME/.zshrc" << 'EOF'
# Basic ZSH configuration
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# History configuration
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.zsh_history"

# Basic aliases
alias ll="ls -alh"
alias la="ls -A"
alias l="ls -CF"

# Enable colors
autoload -U colors && colors
EOF
                    echo "✅ Created basic .zshrc"
                fi
                
                echo ""
                echo "🎉 NoahZSH and all related components have been completely uninstalled!"
                echo "💡 Please restart your terminal or run: source ~/.zshrc"
                echo ""
                echo "To reinstall NoahZSH:"
                echo "curl -fsSL https://raw.githubusercontent.com/nhatcoi/noahzsh/main/bootstrap.sh | bash"
                echo ""
                echo "⚠️  Note: All Oh My Zsh plugins and themes have been removed."
            else
                echo ""
            fi
            ;;
            
        *)
            echo "❌ Unknown command: $1"
            echo "💡 Run 'nsh --help' for available commands"
            ;;
    esac
}

# Create aliases for common commands
alias nsh-open="nsh open"
alias nsh-save="nsh save"
alias nsh-docs="nsh docs"
alias nsh-alias="nsh alias"
alias nsh-config="nsh config"
alias nsh-status="nsh status"

fi
