#!/bin/sh

for i in ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
