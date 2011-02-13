#!/bin/sh

# update all projects
braid update

# make sure command-t is compiled
cd $HOME/.vim/bundle/command-t/ruby/command-t/
ruby extconf.rb
make
cd -

# make sure yajl is compiled
cd $HOME/.vim/bundle/yajl/
./configure -p $HOME/.vim/bundle/yajl
make install
