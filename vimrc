set nocompatible

set number
set ruler
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" pathogen for bundle support
call pathogen#runtime_append_all_bundles() 

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDir=1

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

"Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup


" no scroll bars
set guioptions=aAce

" color theme
color jellybeans+

" enable folding
set nofoldenable
" save fold on leave
"au BufWinLeave *.js,*.c,*.cpp,*.py,*.cc,*.h,*.hpp mkview
"au BufWinEnter *.js,*.c,*.cpp,*.py,*.cc,*.h,*.hpp silent loadview

" turn highlight of
nmap <Leader><Leader> :nohlsearch<CR>

" set super tab shortcut
"let g:SuperTabDefaultCompletionType = 'cotext'
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'

"imap <Plug>delimitMateS-Tab <c-space>
" customize delimitMate
let backspace=2
let g:delimitMate_expand_cr=1

" allow for switching buffers when a file has changes
set hidden

" activate cursor line
set cursorline

" activate spell checking
"set spell
"set the maximum number of suggestions
"set spellsuggest=6

" cycle through buffers
nmap <C-right> :bn<CR>
nmap <C-left> :bp<CR>

" It's useful to map . .`[ to repeat the last command and put the cursor at start of change.
":nmap . .`[

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" activate the verbose mode
verbose

" disable logging for Javascript indentation
let g:js_indent_log=0
