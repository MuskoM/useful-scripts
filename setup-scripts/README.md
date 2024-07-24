# setup-prerequisites.sh

This bash script automates the process of installing packages across different Linux distributions. It detects the current distribution and uses the appropriate package manager to install specified packages.

## Features

- Supports Ubuntu, Debian, Fedora, CentOS, and Arch Linux
- Allows specifying additional packages via command-line options
- Option to disable default packages and only install user-specified packages
- Checks if packages are already installed before attempting installation
- Requires sudo authorization before installing packages
- Provides colored output for better readability

## Usage

```bash
./package_installer.sh [-n] [-p package1] [-p package2] ...
```

Options:
- `-n`: Disable default packages
- `-p`: Specify additional packages (can be used multiple times)

## Examples

1. Install default packages:
   ```bash
   ./package_installer.sh
   ```

2. Install default packages and additional packages:
   ```bash
   ./package_installer.sh -p git -p vim
   ```

3. Install only specified packages (no defaults):
   ```bash
   ./package_installer.sh -n -p git -p vim -p nodejs
   ```

## Default Packages

The script comes with a set of default packages:
- [git](https://git-scm.com/)
- [unzip](https://www.linuxfromscratch.org/blfs/view/systemd/general/unzip.html)
- [gcc](https://gcc.gnu.org/)
- [zsh](https://www.zsh.org/) with [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh)
- [fzf](https://github.com/junegunn/fzf)
- [bat](https://github.com/sharkdp/bat)
- [exa](https://github.com/ogham/exa)
- [duf](https://github.com/muesli/duf)
- [tmux](https://github.com/tmux/tmux/wiki)
- [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)

You can modify these in the script by changing the `default_packages` array.

## Supported Distributions

- Ubuntu
- Debian
- Fedora
- CentOS
- Arch Linux

## Notes

- The script requires sudo privileges to install packages.
- It will prompt for sudo authorization before proceeding with installations.
- If an unsupported distribution is detected, the script will exit with an error message.

## Customization

You can easily customize the script by:
- Modifying the `default_packages` array to change the default packages
- Adding support for more distributions in the case statement

# setup-nvim.sh 
Clones the nvim setup from my github [neovim kickstart repo](https://github.com/MuskoM/kickstart.nvim)

# setup-tmux.sh
Copies the **.tmux.conf** from resources, then pulls and installs Tmux Plugin Manager.

# setup-shell.sh
Sets up OhMyZsh with a saved .zshrc file

# setup-additional-tools.sh
Install tools that are nice to have but not required by any means
