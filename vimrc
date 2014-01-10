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
Bundle 'tpope/vim-sensible'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jiangmiao/auto-pairs'
Bundle 'altercation/vim-colors-solarized'
Bundle 'groenewege/vim-less'
Bundle 'kien/ctrlp.vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'majutsushi/tagbar'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'lukaszb/vim-web-indent'
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
Bundle 'Lokaltog/vim-easymotion'
Bundle 'chriskempson/base16-vim'
Bundle 'mileszs/ack.vim'
Bundle 'mattn/emmet-vim'

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

set number
syntax on


" Beautifier
autocmd FileType javascript noremap <buffer> ff :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> ff :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> ff :call CSSBeautify()<cr>

" remove trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" set omnicompletion functions
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" JSON is javascript, after all
autocmd BufNewFile,BufRead *.json set ft=javascript

" Handlebars is handlebars
autocmd BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hogan,*.hulk,*.hjs,*.hb set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

" make and python use real tabs
au FileType make set noexpandtab
au FileType python set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
au BufRead,BufNewFile *.txt call s:setupWrapping()

" javascript
let javascript_enable_domhtmlcss = 1

" syntastic
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'
"let g:syntastic_filetype_map = { 'mustache.handlebars.html': 'handlebars' }

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Searching
set hlsearch
set ignorecase
set smartcase

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Ultisnips, don't use defaults, they sucks
let g:UltiSnipsSnippetDirectories=["snippets"]

" Status bar
let g:Powerline_symbols = 'fancy'

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDir=1

" ZoomWin configuration
map <Leader><CR> :ZoomWin<CR>

" CTags
set tags=./tags;$HOME " collect all tags up to the home directory
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

function! s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function! s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer <CR>
endfunction


" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" custom ignore for ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|compiled_tpls\|tmp\|build'

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
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace"
set background=dark
colorscheme base16-eighties

" disable folding
set nofoldenable

" allow for switching buffers when a file has changes
set hidden

" activate cursor line
set cursorline

if version >= 703
  " Gundo
  nnoremap <F6> :GundoToggle<CR>

  " Persistent undo
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif

" disable logging for Javascript indentation
let g:js_indent_log=0

" next and prev in location file
map <F4> :lnext<CR>
map <S-F4> :lprevious<CR>

" next and prev in quickfix
map <F5> :cnext<CR>
map <S-F5> :cprevious<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" active mouse
set mouse=a

" toggle auto indent for pasting
" TODO: ZoomWin should be triggered only if there are more then 1 window. No
" idea how to detect the number of window in VIM.
function! ToggleCopyAndPast()
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
