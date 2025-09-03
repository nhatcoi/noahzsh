# Path additions
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Default programs
export EDITOR='vim'
export VISUAL='code'
export PAGER='less'

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python environment
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Go environment
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Java environment
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export PATH="$JAVA_HOME/bin:$PATH"

# Ruby environment
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Android environment
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1  # Tắt tự động update

# History configuration
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTTIMEFORMAT="[%F %T] "

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'      # Bắt đầu blink
export LESS_TERMCAP_md=$'\E[01;31m'      # Bắt đầu bold
export LESS_TERMCAP_me=$'\E[0m'          # Kết thúc mode
export LESS_TERMCAP_se=$'\E[0m'          # Kết thúc standout-mode
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Bắt đầu standout-mode
export LESS_TERMCAP_ue=$'\E[0m'          # Kết thúc underline
export LESS_TERMCAP_us=$'\E[01;32m'      # Bắt đầu underline

# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always {}'"
