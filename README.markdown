Vimate
======

Vimate is a set of plug-ins and configuration file for vim. It is heavily based on 
[Janus](https://github.com/carlhuda/janus). Vimate is targeted at C, C++, and HTML5 developers. 
It comes with a descent numbers of plug-ins and file types.

How to install
--------------

    mv ~/.vim ~/vim-old
    git clone git://github.com/renajohn/vimate.git ~/.vim
    cd ~/.vim
    sh bootstrap.sh

How to updates plug-ins
-----------------------
Vimate uses pathogen.vim to keep each plug-in separated in the ~/.vim/bundle/ directory. 
In addition, vimate uses braid in order to treat plug-ins as vendor branch/sub-projects, 
allowing you to keep all plug-ins up-to-date, independently from Vimate.

    cd .vim
    sh update.sh

Configuration
-------------
UltiSnips all.snippets has the following custom snippets:

- name`<tab>` -> `Your Name`
- @`<tab>` -> `your.email@domain.com`
- sgn`<tab>` -> `Your Name <your.email@domain.com>`

To specify your name and email address, you need to add the following lines in you ~/.profile
    export EMAIL=my.email@domain.com
    export NAME="John Doe"

Plug-ins
--------

Todo

Custom mappings
---------------
**Node:** vimate `<Leader>` key is `/`

| Command | Action |
|:-------------------|:-------|
| `<Leader>` `n`  | Toggle NERDTree | 
| `<Leader>` `r``t`  | create tags DB | 
| `<Leader>``<CR>`  | Zoom in and out current window | 
| `<Leader>` `e`  | Opens a document in current tab | 
| `<Leader>` `t``e`  | Opens document in a new tab | 
| `<C-P>`  | Print the document's directory when in command bar | 
| `<C-Up>`  | Move current line or visual block up | 
| `<C-Down>`  | Move current line or visual block down | 
| `<Leader>``<Leader>`  | Incremental search is turned on. This removes the highlighted search term. | 
| `<C-right>`  | Move to next buffer | 
| `<C-left>`  | Move to previous buffer | 
| `<Leader>` `p`  | Preview markdown document in browser | 
| `<F2>`  | align definition | 
| `<F3>`  | Trigger the command-T command | 
| `<F4>`  | Toggle the tags list | 
| `<F5>`  | Toggle Gundo. Gundo let you navigate in the persistent undo tree. | 
| `<F6>`  | Start a terminal in the current buffer | 

If you ever feel lost, you can type `:Listmaps` to get a list of all
mappings offered by Vimate distribution.
