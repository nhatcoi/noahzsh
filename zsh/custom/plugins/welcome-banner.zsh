# =============================================================================
# Welcome Banner Plugin for NoahZSH
# Inspired by joshuadanpeterson/zsh-welcome-banner
# =============================================================================

# Prevent multiple loading
if [[ -z "$NOAHZSH_WELCOME_BANNER_LOADED" ]]; then
    export NOAHZSH_WELCOME_BANNER_LOADED=1

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    if ! command -v figlet >/dev/null 2>&1; then
        missing_deps+=("figlet")
    fi
    
    if ! command -v lolcat >/dev/null 2>&1; then
        missing_deps+=("lolcat")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo "⚠️  Welcome banner dependencies missing: ${missing_deps[*]}"
        echo "💡 Install with: nsh install-deps"
        return 1
    fi
    
    return 0
}


# Function to center text
center_text() {
    local text="$1"
    local width=$(tput cols 2>/dev/null || echo 80)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%*s%s\n" $padding "" "$text"
}

# ASCII Art Banner
show_banner() {
    if check_dependencies; then
        # NoahZSH ASCII Art with colors and centering
        local banner_text=$(figlet -f slant "NoahZSH" 2>/dev/null)
        if [[ -n "$banner_text" ]]; then
            echo "$banner_text" | lolcat
        else
            # Fallback with colors
            echo -e "\033[1;36m"  # Cyan color
            center_text "╔══════════════════════════════════════════════════════════════╗"
            center_text "║                        \033[1;33mNoahZSH 🚀\033[1;36m                          ║"
            center_text "║              \033[1;32mProfessional ZSH Configuration\033[1;36m                 ║"
            center_text "╚══════════════════════════════════════════════════════════════╝"
            echo -e "\033[0m"  # Reset color
        fi
    else
        # Fallback simple banner with colors
        echo -e "\033[1;36m"  # Cyan color
        center_text "╔══════════════════════════════════════════════════════════════╗"
        center_text "║                        \033[1;33mNoahZSH 🚀\033[1;36m                          ║"
        center_text "║              \033[1;32mProfessional ZSH Configuration\033[1;36m                 ║"
        center_text "╚══════════════════════════════════════════════════════════════╝"
        echo -e "\033[0m"  # Reset color
    fi
}

# Inspirational Quotes
# Inspirational Quotes
get_random_quote() {
    local quotes=(
        "Code is like humor. When you have to explain it, it's bad. - Cory House"
        "First, solve the problem. Then, write the code. - John Johnson"
        "Experience is the name everyone gives to their mistakes. - Oscar Wilde"
        "In order to be irreplaceable, one must always be different. - Coco Chanel"
        "Java is to JavaScript what car is to Carpet. - Chris Heilmann"
        "Sometimes it pays to stay in bed on Monday, rather than spending the rest of the week debugging Monday's code. - Dan Salomon"
        "Perfection is achieved not when there is nothing more to add, but rather when there is nothing more to take away. - Antoine de Saint-Exupery"
        "Ruby is rubbish! PHP is phpantastic! - Nikita Popov"
        "Code never lies, comments sometimes do. - Ron Jeffries"    
        "Fix the cause, not the symptom. - Steve Maguire"
        "Optimism is an occupational hazard of programming: feedback is the treatment. - Kent Beck"
        "When to use iterative development? You should use iterative development only on projects that you want to succeed. - Martin Fowler"
        "Simplicity is the ultimate sophistication. - Leonardo da Vinci"
        "Before software can be reusable it first has to be usable. - Ralph Johnson"
        "Make it work, make it right, make it fast. - Kent Beck"
        "Mã giống như hài hước Khi bạn phải giải thích nó, tức là nó tệ - Cory House"
        "Trước tiên, hãy giải quyết vấn đề Sau đó, hãy viết mã - John Johnson"
        "Kinh nghiệm là cái tên mà mọi người đặt cho những sai lầm của mình - Oscar Wilde"
        "Để không thể thay thế, con người phải luôn khác biệt - Coco Chanel"
        "Java đối với JavaScript cũng giống như xe hơi đối với tấm thảm - Chris Heilmann"
        "Đôi khi nằm trên giường vào sáng thứ Hai còn tốt hơn là phải dành cả tuần để gỡ lỗi đoạn mã viết hôm thứ Hai - Dan Salomon"
        "Sự hoàn hảo đạt được không phải khi không còn gì để thêm vào, mà là khi không còn gì để bớt đi - Antoine de Saint-Exupéry"
        "Ruby là rác rưởi! PHP thì tuyệt vời! - Nikita Popov"
        "Mã thì không bao giờ nói dối, nhưng chú thích đôi khi có - Ron Jeffries"
        "Hãy sửa nguyên nhân, đừng chỉ sửa triệu chứng - Steve Maguire"
        "Lạc quan là rủi ro nghề nghiệp của lập trình: phản hồi là phương thuốc - Kent Beck"
        "Khi nào nên dùng phát triển lặp? Chỉ nên dùng khi bạn muốn dự án thành công - Martin Fowler"
        "Sự đơn giản là đỉnh cao của sự tinh tế - Leonardo da Vinci"
        "Trước khi phần mềm có thể tái sử dụng, nó phải có thể sử dụng được trước đã - Ralph Johnson"
        "Hãy làm cho nó chạy được, rồi làm cho nó đúng, rồi làm cho nó nhanh - Kent Beck"
    )
    
    local random_index=$((RANDOM % ${#quotes[@]}))
    echo "${quotes[$random_index]}"
}

# System Information
show_system_info() {
    local os_name=$(uname -s)
    local os_version=$(uname -r)
    local shell_version=$ZSH_VERSION
    local user_name=$(whoami)
    local host_name=$(hostname)
    local current_time=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "\033[1;34m📊 System Information:\033[0m"
    echo -e "  \033[1;32m👤 User:\033[0m $user_name@$host_name"
    echo -e "  \033[1;32m💻 OS:\033[0m $os_name $os_version"
    echo -e "  \033[1;32m🐚 Shell:\033[0m Zsh $shell_version"
    echo -e "  \033[1;32m⏰ Time:\033[0m $current_time"
    echo -e "  \033[1;32m📁 Directory:\033[0m $(pwd)"
    
    # Show available commands
    echo ""
    echo -e "\033[1;34m💡 Available Commands:\033[0m"
    echo -e "  \033[1;33mnsh --help\033[0m     - Show NoahZSH commands"
    echo -e "  \033[1;33mnsh config\033[0m     - Show configuration"
    echo -e "  \033[1;33mnsh status\033[0m     - Show installation status"
    echo -e "  \033[1;33malias\033[0m          - Show all aliases"
    
    # Show available commands
    echo ""
}

# Main welcome function
welcome_banner() {
    # Only show in interactive shells
    if [[ $- == *i* ]]; then
        show_banner
        echo ""
        
        # Colorful quote
        local quote="💬 $(get_random_quote)"
        if command -v lolcat >/dev/null 2>&1; then
            echo "$quote" | lolcat
        else
            echo -e "\033[1;35m$quote\033[0m"  # Magenta color
        fi
        
        show_system_info
        echo ""
    fi
}

# Auto-run welcome banner (only on new terminal sessions)
if [[ -z "$NOAHZSH_WELCOME_SHOWN" ]]; then
    export NOAHZSH_WELCOME_SHOWN=1
    welcome_banner
fi

fi
