if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-F>

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

" shut up
set visualbell

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

" no scroll bars
set guioptions=aAce

"color
set background=dark
colorscheme solarized

" set trailing char and tab char
set list listchars=tab:\ \ ,trail:·

" window size
set lines=200 columns=200 
winpos 0 0 
set guiheadroom=0

" Open nerd tree by default
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . a:directory
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

