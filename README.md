# NoahZSH

Cấu hình ZSH cá nhân với các alias và plugin hữu ích.

## Yêu cầu hệ thống

- `zsh` shell
  - macOS: Đã cài sẵn
  - Ubuntu/Debian: `sudo apt install zsh`
  - CentOS/RHEL: `sudo yum install zsh`
- `git`
- `curl`

## Cài đặt

```bash
# Clone repository
git clone https://github.com/yourusername/noahzsh.git ~/noahzsh

# Chạy script cài đặt
cd ~/noahzsh
chmod +x bootstrap.sh
./bootstrap.sh

# Khởi động lại terminal hoặc chạy
source ~/.zshrc
```

## Quá trình cài đặt sẽ:

1. Cài đặt Oh My Zsh nếu chưa có
2. Cài đặt plugin zsh-autosuggestions cho tính năng gợi ý lệnh
3. Tạo symbolic link để sử dụng cấu hình có sẵn

## Tính năng có sẵn

1. Terminal có màu sắc (theme robbyrussell)
2. Gợi ý lệnh thông minh khi gõ (như fish shell)
3. Hiển thị trạng thái git trong prompt
4. Các alias hữu ích:
   - `ll`, `la`: Liệt kê file
   - `...`: Di chuyển lên 2 thư mục
   - `gs`, `ga`, `gc`, `gp`: Các lệnh git

## Xử lý sự cố

### Plugin không hoạt động?
```bash
# Cài đặt lại plugin
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cd ~/noahzsh && ./bootstrap.sh
```

### Vấn đề khác?
1. Kiểm tra shell mặc định:
```bash
# Xem shell hiện tại
echo $SHELL

# Đặt zsh làm shell mặc định
chsh -s $(which zsh)
```

2. Cài đặt lại Oh My Zsh:
```bash
rm -rf ~/.oh-my-zsh
cd ~/noahzsh && ./bootstrap.sh
```

## Cấu hình có sẵn

- `zsh/.zshrc`: File cấu hình chính
- `zsh/custom/aliases.zsh`: Các alias cho lệnh thông dụng
- `zsh/custom/export.zsh`: Cấu hình biến môi trường

## Tùy chỉnh

Bạn có thể chỉnh sửa:
- `aliases.zsh` để thêm/sửa alias
- `export.zsh` để cấu hình biến môi trường
- `.zshrc` để thay đổi theme hoặc thêm plugins

## Cập nhật

Để cập nhật cấu hình:
```bash
cd ~/noahzsh
git pull
./bootstrap.sh
```
