#!/bin/sh

# update all projects
braid update

# make sure command-t is compiled
cd $HOME/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make
cd -

