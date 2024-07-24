#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default packages
default_packages=("git" "unzip" "gcc" "zsh" "fzf")
packages=()

# Parse command line options
use_defaults=true
while getopts "p:n" opt; do
  case $opt in
    p)
      packages+=("$OPTARG")
      ;;
    n)
      use_defaults=false
      ;;
    \?)
      echo "Usage: $0 [-n] [-p package]" >&2
      echo "  -n: Do not use default packages" >&2
      echo "  -p: Specify additional packages" >&2
      exit 1
      ;;
  esac
done

# Add default packages if not disabled
if $use_defaults; then
  packages+=("${default_packages[@]}")
fi

# Check if any packages are specified
if [ ${#packages[@]} -eq 0 ]; then
  echo -e "${RED}No packages specified. Exiting.${NC}"
  exit 1
fi

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
fi

# Sudo authorization
echo "Sudo access is required to install packages."
sudo -v || { echo -e "${RED}Failed to get sudo privileges. Exiting.${NC}"; exit 1; }

case $OS in
    "Ubuntu"|"Debian")
        for pkg in "${packages[@]}"; do
            if ! dpkg -s "$pkg" >/dev/null 2>&1; then
                echo -e "Installing ${GREEN}$pkg${NC}"
                sudo apt-get install -y "$pkg"
            else
                echo -e "${GREEN}$pkg${NC} is already installed"
            fi
        done
        ;;
    "Fedora"|"CentOS")
        for pkg in "${packages[@]}"; do
            if ! rpm -q "$pkg" >/dev/null 2>&1; then
                echo -e "Installing ${GREEN}$pkg${NC}"
                sudo dnf install -y "$pkg"
            else
                echo -e "${GREEN}$pkg${NC} is already installed"
            fi
        done
        ;;
    "Arch Linux")
        for pkg in "${packages[@]}"; do
            if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
                echo -e "Installing ${GREEN}$pkg${NC}"
                sudo pacman -S --noconfirm "$pkg"
            else
                echo -e "${GREEN}$pkg${NC} is already installed"
            fi
        done
        ;;
    *)
        echo -e "${RED}Unsupported distro: $OS${NC}"
        exit 1
        ;;
esac