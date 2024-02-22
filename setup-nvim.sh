cd $HOME

NVIM_CONFIG_SRC=$RESOURCES/nvim/*
NVIM_DIR=$HOME/.config/nvim

mkdir $NVIM_DIR

cp -r $NVIM_CONFIG_SRC $NVIM_DIR

echo alias vi="nvim" >> $HOME/.zshrc
