#!/bin/sh

for i in ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

cd $HOME/.vim/bundle/command-t/ruby/command-t
rake make

