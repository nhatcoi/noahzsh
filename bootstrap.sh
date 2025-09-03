#!/bin/bash

###########################################
# bootstrap.sh
# Script cài đặt cấu hình ZSH tự động
#
# Các bước thực hiện:
# 1. Kiểm tra các công cụ cần thiết (zsh, git)
# 2. Cài đặt Oh My Zsh nếu chưa có
# 3. Cài đặt plugin zsh-autosuggestions
# 4. Tạo symbolic link cho .zshrc
###########################################

# Thiết lập màu sắc cho output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Bật chế độ báo lỗi nghiêm ngặt
# Script sẽ dừng ngay khi gặp lỗi
set -e

# Function kiểm tra xem một command có tồn tại không
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# BƯỚC 1: Kiểm tra các công cụ cần thiết
echo -e "${BLUE}Checking prerequisites...${NC}"

# Check for zsh
if ! command_exists zsh; then
    echo -e "${RED}zsh is not installed. Please install zsh first:${NC}"
    echo -e "${YELLOW}macOS: brew install zsh${NC}"
    echo -e "${YELLOW}Ubuntu/Debian: sudo apt install zsh${NC}"
    echo -e "${YELLOW}CentOS/RHEL: sudo yum install zsh${NC}"
    exit 1
fi

# Check for git
if ! command_exists git; then
    echo -e "${RED}git is not installed. Please install git first.${NC}"
    exit 1
fi

# Check for curl
if ! command_exists curl; then
    echo -e "${RED}curl is not installed. Please install curl first.${NC}"
    exit 1
fi

# BƯỚC 2: Cài đặt Oh My Zsh
# Oh My Zsh là framework cung cấp:
# - Quản lý plugin và theme
# - Tích hợp git và các công cụ khác
# - Completion và syntax highlighting
echo -e "${BLUE}Setting up NoahZSH configuration...${NC}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Oh My Zsh not found. Installing...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# BƯỚC 3: Cài đặt plugin zsh-autosuggestions
# Plugin này cung cấp:
# - Gợi ý lệnh dựa trên lịch sử
# - Tự động hoàn thành lệnh khi gõ
# - Fish shell style suggestions
echo -e "${BLUE}Setting up zsh-autosuggestions...${NC}"

# Thiết lập đường dẫn cho plugin
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
PLUGIN_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Cài đặt hoặc cập nhật plugin
# QUAN TRỌNG: Phải cài plugin trước khi link .zshrc
# vì trong .zshrc có khai báo sử dụng plugin này
if [ -d "$PLUGIN_DIR" ]; then
    echo -e "${GREEN}Updating zsh-autosuggestions...${NC}"
    cd "$PLUGIN_DIR" && git pull
else
    echo -e "${GREEN}Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
fi

# Quay về thư mục gốc của dự án
cd ~/noahzsh

# BƯỚC 4: Cài đặt file cấu hình
# LƯU Ý: Chỉ link .zshrc sau khi đã cài đặt xong plugin
# để tránh lỗi plugin không tồn tại

# Backup file .zshrc cũ (nếu có)
# File backup sẽ có tên dạng .zshrc.backup.YYYYMMDD_HHMMSS
if [ -f ~/.zshrc ]; then
    echo -e "${BLUE}Backing up existing .zshrc...${NC}"
    mv ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Tạo symbolic link từ file .zshrc trong repo đến ~/.zshrc
# Khi file trong repo thay đổi, file ~/.zshrc cũng sẽ được cập nhật theo
echo -e "${BLUE}Creating symbolic link for .zshrc...${NC}"
ln -sf ~/noahzsh/zsh/.zshrc ~/.zshrc

# Thông báo hoàn thành
echo -e "${GREEN}NoahZSH setup complete!${NC}"
echo -e "${BLUE}Please restart your terminal or run: source ~/.zshrc${NC}"

# Khi chạy source ~/.zshrc:
# 1. Load Oh My Zsh
# 2. Load các plugin (git, zsh-autosuggestions)
# 3. Load các file cấu hình tùy chỉnh:
#    - aliases.zsh: Các alias cho lệnh thường dùng
#    - export.zsh: Các biến môi trường
