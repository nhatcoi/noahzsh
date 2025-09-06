# Aliases chung
alias c="clear"
alias h="history"
alias q="exit"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"
alias p="pwd"

# List files
alias ls="ls -G"
alias ll="ls -alh"
alias la="ls -A"
alias l="ls -CF"
alias lsd="ls -l | grep '^d'"  # Chỉ list directories

# Git
alias g="git"
alias gcl="git clone"

alias gcm="git commit -m" # commit
alias gcma="git commit -a -m"
alias gcmam="git commit --amend"
alias gcmempty="git commit --allow-empty -m"


alias gck="git checkout" # checkout
alias gckb="git checkout -b"

alias gs="git status"
alias ga="git add"
alias gaa="git add ."

alias gp="git push"
alias gpo="git push origin"
alias gpu="git push -u origin"
alias gpf="git push --force"
alias gpfwl="git push --force-with-lease"

alias gpl="git pull"
alias gplo="git pull origin"

alias gf="git fetch"
alias gfo="git fetch origin"

alias gd="git diff"
alias gb="git branch"
alias glog="git log --oneline --decorate --graph"

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dimg="docker images"
alias drm="docker rm"
alias drmi="docker rmi"

# npm aliases
alias ni="npm install"
alias nid="npm install --save-dev"
alias nrm="npm remove"
alias nrs="npm run start"
alias nrb="npm run build"
alias nrt="npm run test"

# Directory shortcuts
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dev="cd ~/Development"

# System
alias flush="sudo killall -HUP mDNSResponder"  # Flush DNS
alias ip="curl -s ipinfo.io/ip"               # Get public IP
alias localip="ipconfig getifaddr en0"        # Get local IP
alias weather="curl wttr.in"                  # Check weather

# Các alias tiện ích
alias myip="curl http://ipecho.net/plain; echo"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"  # Xóa .DS_Store
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"                # Copy SSH key
alias reloadshell="source $HOME/.zshrc"                       # Reload ZSH

# Tạo và di chuyển vào thư mục
function mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Extract các loại file nén
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' không thể giải nén" ;;
        esac
    else
        echo "'$1' không phải là file hợp lệ"
    fi
}
