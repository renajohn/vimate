Vimate
======

Vimate is a set of plug-ins and configuration file for vim. It is heavily based on the excellent 
[Janus](https://github.com/carlhuda/janus). Vimate is targeted at C, C++, and HTML5 developers. 
It comes with a descent numbers of plug-ins and file types.

How to install
--------------

    mv ~/.vim ~/vim-old
    git clone git://github.com/renajohn/vimate.git ~/.vim
    cd ~/.vim
    sh bootstrap.sh

    [sudo] gem install github-markup
    [sudo] gem install redcarpet # for markdown wiki notation

How to updates plug-ins
-----------------------
Vimate uses pathogen.vim to keep each plug-in separated in the ~/.vim/bundle/ directory. 
In addition, vimate uses braid in order to treat plug-ins as vendor branch/sub-projects, 
allowing you to keep all plug-ins up-to-date, independently from Vimate.

    cd .vim
    sh update.sh

**NOTE**: braid is not currently working with ruby 1.9, if you use rvm,
switch to ruby 1.8.+ before calling `update.sh`.

Configuration
-------------
UltiSnips all.snippets has the following custom snippets:

- name`<tab>` -> `Your Name`
- @`<tab>` -> `your.email@domain.com`
- sgn`<tab>` -> `Your Name <your.email@domain.com>`

To specify your name and email address, you need to add the following lines in you ~/.profile
    export EMAIL=my.email@domain.com
    export NAME="John Doe"

You can create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

    echo color desert  > ~/.vimrc.local
    echo color molokai > ~/.gvimrc.local

Solarized color scheme
----------------------
The default color scheme is
[Solarized](http://ethanschoonover.com/solarized), a highly professional
color scheme which comes in dark or light background.
You can use `F8` to toggle from dark to light theme.

Solarized in terminal
---------------------
Solarized colorscheme needs some special colors that the terminal does
not provide. To have a sweat experience you can change the default
palette of your terminal emulator or decide to use the 256 degraded
colors in vim.

Instructions are in Solarized [README](http://ethanschoonover.com/solarized/vim-colors-solarized#important-note-for-terminal-users)

Plug-ins
--------
## Ack.vim

Ack.vim uses ack to search inside the current directory for a pattern.
You can learn more about it with :help Ack

## Tabularized

Tabularized lets you align statements on their equal signs, make comment
boxes, align comments, align declarations, etc.

* `:Tab /=` to align on `=`'s
* Tabularized on `=` and `:` are mapped on `<Leader>a=` and `<Leader>a:`
  respectively

When working on table like the following:
        
    | a | b |
    | c | d |

Tabularized will align the table each time `|` is typed. 

## Command-T

Command-T provides a mechanism for searching for a file inside the
current working directory. It behaves similarly to command-t in
TextMate.

**Customizations**: Vimate rebinds `F3` to bring up this
plug-in. It defaults to `<Leader>t`.

## ConqueTerm

ConqueTerm embeds a basic terminal inside a vim buffer. The terminal has
an insert mode in which you can type commands, tab complete and use the
terminal like normal. You can also escape out of insert mode to use
other vim commands on the buffer, like yank and paste.

**Customizations**: Vimate binds F6 to bring up
`:ConqueTerm bash --login` in the current buffer.

**Note**: To get colors working, you might have to `export TERM=xterm`
and use `ls -G` or `gls --color`

## indent\_object

Indent object creates a "text object" that is relative to the current
ident. Text objects work inside of visual mode, and with `c` (change),
`d` (delete) and `y` (yank). For instance, try going into a method in
normal mode, and type `v ii`. Then repeat `ii`.

## surround

Surround allows you to modify "surroundings" around the current text.
For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more; check it out at `:help surround`

## NERDCommenter

NERDCommenter allows you to wrangle your code comments, regardless of
filetype. View `:help NERDCommenter` for all the details.

## SuperTab

In insert mode, start typing something and hit `<TAB>` to tab-complete
based on the current context.

## ctags

Vimate includes the TagList plug-in, which binds `:Tlist` to an overview
panel that lists all ctags for easy navigation.

**Customizations**: Vimate binds `<Leader>rt` to the ctags command to
update tags. `F4` will give you a list of all tags in the current file.

**Note**: For full language support, run `brew install ctags` to install
exuberant-ctags.

**Tip**: Check out `:help ctags` for information about VIM's built-in
ctag support. Tag navigation creates a stack which can traversed via
`Ctrl-]` (to find the source of a token) and `Ctrl-T` (to jump back up
one level).

## Git Support (Fugitive)

Fugitive adds pervasive git support to git directories in vim. For more
information, use `:help fugitive`

Use `:Gstatus` to view `git status` and type `-` on any file to stage or
unstage it. Type `p` on a file to enter `git add -p` and stage specific
hunks in the file. Use 'C' to commit changes.

## ZoomWin

When working with split windows, ZoomWin lets you zoom into a window and
out again using `Ctrl-W o`

**Customizations**: Vimate binds `<Leader><return>` to `:ZoomWin`

## Hammer

Hammer takes the current buffer, tries to convert it to HTML, and opens
it in your default browser. Hammer is enabled for Markdown files, but
has support for much more.

**Customizations**: Vimate binds `<Leader> p` to `:Hammer`

## Gundo

Gundo let you navigate into the undo tree from VIM.

**Customizations**: Vimate binds `F5` to Gundo. Vimate has also
activated by default the persistent undo. If you modify your file, save
and quit, you can re-open it and still revert your changes! How cool is
that?

Custom mappings
---------------
**Node:** vimate `<Leader>` key is `/`

|Command              |Action
|:------------------- |:-------
|`F2`                 |Toggle copy and past mode. This is very useful when you want to past something in vim running in the terminal. It will deactivate the auto-indent and auto-insert of parenthesis. 
|`<Leader>` `n`       |Toggle NERDTree
|`<Leader>` `<CR>`    |Zoom in and out current window
|`<Leader>` `e`       |expands to `:e {directory of current file}/` (open in the current buffer)
|`<Leader>` `t` `e`   |expands to `:te {directory of current file}/` (open in a new tab)
|`<C-P>`              |Insert the directory of the current file when in command bar
|`<C-Up>`             |Move current line or visual block up
|`<C-Down>`           |Move current line or visual block down
|`<Leader>` `<Leader>`|Incremental search is turned on. This removes the highlighted search term.
|`<F8>` |Toggle between dark and light theme for Solarized.

If you ever feel lost, you can type `:Listmaps` to get a list of all
mappings offered by Vimate distribution.

Useful command with VIM:
------------------------

### Editing

**Normal mode**

| Command | action
|:---------------|:---------------
| `daw` |**d**elete (**a**round) the **w**ord under the cursor, even if cursor is in the middle of the word. If there is a space after or before the word, it will be deleted too.
|`diw` |**d**elete (**i**nside) the **w**ord under the cursor, even if cursor is in the middle of the word. No space deleted.
|`I` |Move cursor at the beginning of the line and enter in **I**nsert mode.
|`A` |Append at the end of the line. (Very useful)

**Visual block mode**

| Command | action
|:---------------|:---------------
|`I` |**I**nsert text in from of every selected lines 
|`$A` |**A**ppend text at the end of every selected lines (`$` extends the block selection to the longest line in the selection).

