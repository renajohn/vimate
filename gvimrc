" Vimate v0.3.2

if has("gui_macvim")
  " make clipboard work with std clipboard
  set clipboard=unnamed
else
  " make clipboard work with std clipboard
  " Note that X11 uses the plus register for
  " std clipboard, not the * as Mac os or windows
  set clipboard=unnamedplus

  " set my favorite font for gvim
  "set guifont=Andale\ Mono\ 10
endif

" set my favorite font
set guifont=Source\ Code\ Pro\ Light\ for\ Powerline:h15

" shut up
set visualbell

" Start without the toolbar
set guioptions-=T

" no scroll bars
set guioptions=aAce

" set trailing char and tab char
set list listchars=tab:\ \ ,trail:·

" window size
set lines=200 columns=200 
winpos 0 0 
set guiheadroom=0

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

