#!/bin/bash

git clone https://github.com/MuskoM/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo alias vi="nvim" >> $HOME/.zshrc
