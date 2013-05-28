" Vimate v0.3.2

set nocompatible

" specify where node is
let $JS_CMD='node'

" add a line at 80 c
set cc=80

" pathogen for bundle support
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" all bundles
Bundle 'Lokaltog/vim-powerline'
Bundle 'Raimondi/delimitMate'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'nono/vim-handlebars'
Bundle 'pangloss/vim-javascript'
Bundle 'rphillips/vim-zoomwin'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/UltiSnips'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/Lucius'

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

set number
set ruler
syntax on

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Beautifier
autocmd FileType javascript noremap <buffer> <leader>ff :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <leader>ff :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>ff :call CSSBeautify()<cr>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
let g:SuperTabDefaultCompletionType = "context"
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Ultisnips, don't use defaults, they sucks
let g:UltiSnipsSnippetDirectories=["snippets"]

" set omnicompletion functions
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html let b:delimitMate_autoclose = 0
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Status bar
let g:Powerline_symbols = 'fancy'
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDir=1

" align declarations
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /^[^:]*\zs:<CR>
vmap <Leader>a: :Tabularize /^[^:]*\zs:<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" ZoomWin configuration
map <Leader><CR> :ZoomWin<CR>

" CTags
set tags=./tags;$HOME " collect all tags up to the home directory
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
  map <buffer> <Leader>p :Hammer <CR>
endfunction

" JSON is javascript, after all
autocmd BufNewFile,BufRead *.json set ft=javascript

" NFO files is XML
autocmd BufNewFile,BufRead *.nfo set ft=xml

" make and python use real tabs
au FileType make set noexpandtab
au FileType python set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" activate spell checking
set spell

" set the maximum number of suggestions
set spellsuggest=6

" color theme
set background=dark
colorscheme lucius
"LuciusDarkLowContrast

call togglebg#map("<F8>")

" enable folding
set nofoldenable

" turn highlight of
nmap <Leader><Leader> :nohlsearch<CR>

" allow for switching buffers when a file has changes
set hidden

" activate cursor line
set cursorline

if version >= 703
  " Gundo
  nnoremap <F5> :GundoToggle<CR>

  " Persistent undo
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif

" disable logging for Javascript indentation
let g:js_indent_log=0

map <F4> :TagbarToggle<CR>

" active mouse
set mouse=a

" toggle auto indent for pasting
" TODO: ZoomWin should be triggered only if there are more then 1 window. No
" idea how to detect the number of window in VIM.
function ToggleCopyAndPast()
  set invpaste paste?
  if &mouse == ""
    set number
    let &mouse = "a"
    :ZoomWin
  else
    set nonumber
    let &mouse=""
    :ZoomWin
  endif
endfunction

noremap <F2> :call ToggleCopyAndPast()<CR>
inoremap <F2> <Esc>:call ToggleCopyAndPast()<CR>i
set pastetoggle=<F2>

" activate bracketed past mode
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
endif

" change cursor shape in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
