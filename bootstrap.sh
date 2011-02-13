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

# make sure yajl is compiled
cd $HOME/.vim/bundle/yajl/
./configure -p $HOME/.vim/bundle/yajl
make install
