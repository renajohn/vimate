#!/bin/sh

git submodule init
git submodule update

for i in ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done

mkdir ~/.vim/undodir
mkdir ~/.vim/view
mkdir ~/.vim/backup

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

cd $HOME/.vim/bundle/command-t/ruby/command-t
rake make

# make sure yajl is compiled
cd $HOME/.vim/bundle/yajl/
./configure -p $HOME/.vim/bundle/yajl
make install
