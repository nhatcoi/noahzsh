# NoahZSH

A minimalist ZSH configuration setup with essential plugins and custom configurations.

## Features

- Clean and simple configuration
- Auto-suggestions plugin
- Custom aliases and exports
- Easy one-line installation

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/nhatcoi/noahzsh/main/bootstrap.sh | bash
```

## Requirements

- `zsh` shell
- `git`
- `curl`

## What's Included

- `zsh-autosuggestions`: Fish-like autosuggestions for ZSH
- Custom aliases for common commands
- Environment variables setup
- Robbyrussell theme
- Git integration

## Manual Setup

1. Clone the repository:
```bash
git clone https://github.com/nhatcoi/noahzsh.git ~/noahzsh
```

2. Run the bootstrap script:
```bash
cd ~/noahzsh && chmod +x bootstrap.sh && ./bootstrap.sh
```

## Structure

```
noahzsh/
├── bootstrap.sh           # Installation script
└── zsh/
    ├── .zshrc            # Main ZSH configuration
    └── custom/
        ├── aliases.zsh    # Custom aliases
        ├── export.zsh     # Environment variables
        └── plugins/       # Custom plugins directory
```

## Troubleshooting

### Plugin issues
```bash
# Reinstall plugin
rm -rf $ZSH_CUSTOM/plugins/zsh-autosuggestions
cd ~/noahzsh && ./bootstrap.sh
```

### Other issues
```bash
# Set ZSH as default shell
chsh -s $(which zsh)

# Reinstall Oh My Zsh
rm -rf ~/.oh-my-zsh
cd ~/noahzsh && ./bootstrap.sh
```

## Customization

Edit these files to customize your setup:
- `aliases.zsh`: Add/modify command aliases
- `export.zsh`: Configure environment variables
- `.zshrc`: Change theme or add plugins

## Updates

```bash
cd ~/noahzsh && git pull && ./bootstrap.sh
```

## License

MIT

## Author

nhatcoi

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
