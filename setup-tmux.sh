cd $HOME

TMUX_CONFIG_FILE=./resources/.tmux.conf

mkdir $HOME/.tmux

cp $TMUX_CONFIG_FILE $HOME/

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

$HOME/.tmux/plugins/tpm/bin/install_plugins

