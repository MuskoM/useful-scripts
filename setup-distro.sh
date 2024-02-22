# Validate is root
sudo -v
# Get variables used later 
DISTRO=$(lsb_release -is)
export RESOURCES=$(pwd)/resources

# Distro dependent configuration
# ==============================

case $DISTRO in
	Ubuntu)
		echo -n "Setting up $DISTRO"

		# Update the system
		sudo apt update -y
		sudo apt upgrade -y

		# Add required apps
		sudo apt install wget curl

		# Installs add apt-repository
		sudo apt-get install software-properties-common

		# Add Neovim Repostiory and install
		sudo add-apt-repository ppa:neovim-ppa/unstable
		sudo apt install neovim

		# Install Zellij Terminal Multiplexer
		wget -P $HOME https://github.com/zellij-org/zellij/releases/download/v0.39.2/zellij-x86_64-unknown-linux-musl.tar.gz && tar -C $HOME -xf "${HOME}/zellij-x86_64-unknown-linux-musl.tar.gz"
		rm ${HOME}/zellij-x86_64-unknown-linux-musl*

		mkdir -p "${HOME}/.local/bin"
		cp "${HOME}/zellij" "${HOME}/.local/bin/zellij"
		rm "${HOME}/zellij"

		# Install Z Shell
		apt install zsh
		echo $(zsh --version)
		sudo chsh -s $(which zsh)

		# Install exa - better ls
		sudo apt install exa
		
		# Install bat - better cat
		sudo apt install bat
		
		;;
	*)
		echo "Not acceptable"
		exit
	;;
esac

# Distro independent configuration
# =================================

# Make .config directories for config files
mkdir -p $HOME/.config
sudo chmod 777 setup-nvim.sh
./setup-nvim.sh

# Make local bin directory and add to path
mkdir -p $HOME/.local/bin

# Install Oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Replace basic .zshrc with customized
cp ${RESOURCES}/.zshrc $HOME/.zshrc
