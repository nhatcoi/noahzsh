# =============================================================================
# ZSH Autosuggestions Configuration
# =============================================================================

# Prevent multiple loading
if [[ -z "$NOAHZSH_AUTOSUGGESTIONS_LOADED" ]]; then
    export NOAHZSH_AUTOSUGGESTIONS_LOADED=1
    
    # Load zsh-autosuggestions plugin if available
    if [[ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
        
        # Configuration

        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        ZSH_AUTOSUGGEST_USE_ASYNC=true
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        
        # Key bindings
        bindkey '^[[C' forward-char                    # Right arrow
        bindkey '^[[D' backward-char                   # Left arrow
        bindkey '^[^M' autosuggest-accept              # Alt+Enter
        bindkey '^[^I' autosuggest-execute             # Alt+Tab
        
        # zsh-autosuggestions loaded silently
    else
        # zsh-autosuggestions not found
    fi
fi
