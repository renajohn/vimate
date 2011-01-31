Vimate
======

Vimate is a set of plug-ins and configuration file for vim. It is heavily based on https://github.com/carlhuda/janus.

How to install
--------------

  cd $HOME
  mv .vim vim-old
  git clone git://github.com/carlhuda/janus.git ~/.vim
  cd .vim
  sh bootstrap.sh

How to updates plug-ins
-----------------------
Vimate uses pathogen.vim to keep each plug-in separeted in the .vim/bundle/ dir. In addition, vimate uses braid in order to treat plug-ins as vendor branch/sub-projects, allowing you to keep all plug-ins up-to-date, independently from Vimate.

  cd .vim
  sh update.sh

