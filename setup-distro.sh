# Validate is root
sudo -v
# Get variables used later 
DISTRO=$(lsb_release -is)
USER=$(whoami)
USERDIR=/home/$USER/

cd $USERDIR

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

		# Add Neovim Repostiory
		sudo add-apt-repository ppa:neovim-ppa/unstable
		sudo apt install neovim

		# Install Zellij Terminal Multiplexer
		wget -P $USERDIR https://github.com/zellij-org/zellij/releases/download/v0.39.2/zellij-x86_64-unknown-linux-musl.tar.gz && tar -C $USERDIR -xf "${USERDIR}zellij-x86_64-unknown-linux-musl.tar.gz"
		rm ${USERDIR}zellij-x86_64-unknown-linux-musl*

		mkdir -p "${USERDIR}.local/bin"
		cp "${USERDIR}zellij" "${USERDIR}.local/bin/zellij"
		rm "${USERDIR}zellij"

		# Install Z Shell
		apt install zsh
		echo $(zsh --version)
		sudo chsh -s $(which zsh)
		;;
	*)
		echo "Not acceptable"
		exit
	;;
esac

# Distro independent configuration
# =================================

# Make .config directories for config files
mkdir -p .config/nvim

# Make local bin directory
mkdir -p .local/bin


# Install Oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
