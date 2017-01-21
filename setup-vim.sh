#!/bin/bash
sudo apt-get install -y curl vim-gnome gcc make &&\
cd ~/dotfiles &&\
cp .vimrc ~/ &&\
cd ~/.cache &&\
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh &&\
sh ./installer.sh dein
vim ~/dotfiles/setup.sh
