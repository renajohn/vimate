#!/bin/sh

for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done

mkdir ~/.vim/undodir
mkdir ~/.vim/view
mkdir ~/.vim/backup

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

cd ~/.vim/ruby/command-t
ruby extconf.rb
make
cd -
