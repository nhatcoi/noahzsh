# =============================================================================
# Oh My Zsh Configuration
# =============================================================================

# Prevent multiple loading
if [[ -z "$NOAHZSH_OHMYZSH_LOADED" ]]; then
    export NOAHZSH_OHMYZSH_LOADED=1
    
    # Oh My Zsh installation path
    export ZSH="$HOME/.oh-my-zsh"

    # Custom folder path
    export ZSH_CUSTOM="$HOME/noahzsh/zsh/custom"

# Theme configuration
ZSH_THEME="robbyrussell"

# Plugin configuration
plugins=()

# Oh My Zsh settings
DISABLE_AUTO_UPDATE="true"                    # Disable auto-update
DISABLE_UPDATE_PROMPT="true"                  # Disable update prompt
DISABLE_MAGIC_FUNCTIONS="true"                # Disable magic functions for better paste
COMPLETION_WAITING_DOTS="true"                # Show dots while waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true"          # Faster git status for large repos

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_VERIFY                            # Verify history expansion
setopt SHARE_HISTORY                          # Share history between sessions
setopt APPEND_HISTORY                         # Append to history file
setopt INC_APPEND_HISTORY                     # Append to history immediately
setopt HIST_IGNORE_DUPS                       # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS                   # Ignore all duplicates
setopt HIST_FIND_NO_DUPS                      # Don't show duplicates in history search
setopt HIST_SAVE_NO_DUPS                      # Don't save duplicates
setopt HIST_REDUCE_BLANKS                     # Remove blank lines from history

    # Load Oh My Zsh
    if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
        source "$ZSH/oh-my-zsh.sh"
        # Oh My Zsh loaded silently
    else
        echo "❌ Oh My Zsh not found. Please install it first."
    fi
fi
