Vimate
======

Vimate is a set of plug-ins and configuration file for vim. It is heavily based on https://github.com/carlhuda/janus.

How to install
--------------

    mv ~/.vim ~/vim-old
    git clone git://github.com/renajohn/vimate.git ~/.vim
    cd ~/.vim
    sh bootstrap.sh

How to updates plug-ins
-----------------------
Vimate uses pathogen.vim to keep each plug-in separated in the ~/.vim/bundle/ directory. In addition, vimate uses braid in order to treat plug-ins as vendor branch/sub-projects, allowing you to keep all plug-ins up-to-date, independently from Vimate.

    cd .vim
    sh update.sh

Configuration
-------------
UltiSnips all.snippets has the following custom snippets:
# name -> Your Name
# @ -> your.email@domain.com
# sgn -> Your Name <your.email@domain.com>

To specify your name and email address, you need to add the following lines in you ~/.profile
    export EMAIL=my.email@domain.com
    export NAME="John Doe"

Plug-ins and custom mappings
----------------------------

# Aligning variable definition: <F2>
# Command-T <F3>
# TagList <F4>
# GUndo <F5>. Vim has a very nice persistent undo, but using it is hard,
though gundo plug-in. Gundo let you navigate in the undo tree and merge
states. It is like a git in vim.
# Terminal <F6>
