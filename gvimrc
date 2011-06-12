
if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-F>
  "map <D-F> :Ack<space>

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " set my favorite font
  set guifont=Panic\ Sans:h12

  " open color picker
  imap <D-C> <ESC>:ColorHEX<cr>a
  nmap <D-C> :ColorHEX<cr>
  vmap <D-C> d:ColorHEX<cr>

  " make clipboard work with std clipboard
  set clipboard=unnamed
else
  " make clipboard work with std clipboard
  " Note that X11 uses the plus register for
  " std clipboard, not the * as Mac os or windows
  set clipboard=unnamedplus

  " set my favorite font for gvim
  set guifont=Andale\ Mono\ 10
endif

"custom tab stuff
" tab navigation like safari
" idea adopted from: [[VimTip1221]]
:nmap <D-S-[> :tabprevious<CR>
:nmap <D-S-]> :tabnext<CR>
:map <D-S-[> :tabprevious<CR>
:map <D-S-]> :tabnext<CR>
:imap <D-S-[> <Esc>:tabprevious<CR>i
:imap <D-S-]> <Esc>:tabnext<CR>i
:nmap <D-t> :tabnew<CR>
:imap <D-t> <Esc>:tabnew<CR>

" Start without the toolbar
set guioptions-=T


"color
set background=dark
colorscheme solarized

" activate spell checking
set spell
" set the maximum number of suggestions
set spellsuggest=6

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


