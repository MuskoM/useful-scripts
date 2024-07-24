cd $HOME

TMUX_CONFIG_FILE=$RESOURCES/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp $TMUX_CONFIG_FILE $HOME/

$HOME/.tmux/plugins/tpm/bin/install_plugins

