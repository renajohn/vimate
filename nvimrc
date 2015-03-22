" Vimate v0.3.2

set nocompatible

" VIM Setup {{{ ===============================================================

" <Leader> & <LocalLeader> mapping {{{

let mapleader='\'
let maplocalleader= ' '

" }}}

" Basic options {{{

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible
set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
" The next two lines are quite tricky, but in Gvim, if you don't do this, if you
" only hide all the scrollbars, the vertical scrollbar is showed anyway
set go+=rRlLbh                  " show all the scrollbars
set go-=rRlLbh                  " hide all the scrollbars
set visualbell                  " turn on the visual bell
set cursorline                  " highlight the line under the cursor
set fillchars+=vert:│           " better looking for windows separator
set title                       " set the terminal title to the current file
set noshowcmd                     " shows partial commands
set hidden                      " hide the inactive buffers
set ruler                       " sets a permanent rule
set lazyredraw                  " only redraws if it is needed
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly
set backspace=indent,eol,start  " defines the backspace key behavior
set nofoldenable                " disable folding
set noshowmode                  " Hide the default mode text (e.g. -- INSERT --)

set modeline                    " interpret vim commands in files (like the last comment of this file)
set modelines=10                " number of lines checked to find each modeline
set number                      " show line numbers
set relativenumber              " show relative line
set spell                       " activate spell checking
set spellsuggest=6              " set the maximum number of suggestions

" }}}

" Wildmenu {{{

set wildmenu                        " Command line autocompletion
set wildmode=list:longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,.git,*.rbc

" }}}

" Searching {{{

set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
set nosmartcase                   " smart case ignore
set noignorecase                  " ignore case letters

" turn highlight off
nmap \\ :nohlsearch<CR>

" }}}

" History and permanent undo levels {{{

set undofile
set history=1000
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=1000

" }}}

" Tabs, space and wrapping {{{

set nowrap
set expandtab                  " spaces instead of tabs
set tabstop=2                  " a tab = two spaces
set shiftwidth=2               " number of spaces for auto-indent
set softtabstop=2              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
set smartindent                " Try to guess indent

" set formatoptions=qrn1ct
set textwidth=80
set colorcolumn=81
set formatoptions-=tc " don't add EOL

function! ToggleWrap()
    let s:nowrap_cc_bg = [22, '#005f00']
    redir => s:curr_cc_hi
    silent hi ColorColumn
    redir END
    let s:curr_cc_ctermbg = matchstr(s:curr_cc_hi, 'ctermbg=\zs.\{-}\s\ze\1')
    let s:curr_cc_guibg = matchstr(s:curr_cc_hi, 'guibg=\zs.\{-}\_$\ze\1')
    if s:curr_cc_ctermbg != s:nowrap_cc_bg[0]
        let g:curr_cc_ctermbg = s:curr_cc_ctermbg
    endif
    if s:curr_cc_guibg != s:nowrap_cc_bg[1]
        let g:curr_cc_guibg = s:curr_cc_guibg
    endif
    if &textwidth == 80
        set textwidth=0
        exec 'hi ColorColumn ctermbg='.s:nowrap_cc_bg[0].
                    \' guibg='.s:nowrap_cc_bg[1]
    elseif &textwidth == 0
        set textwidth=80
        exec 'hi ColorColumn ctermbg='.g:curr_cc_ctermbg.
                    \' guibg='.g:curr_cc_guibg
    endif
endfunction

nmap <silent><Leader>ew :call ToggleWrap()<CR>

" }}}

" variables {{{

" specify where node is
let $JS_CMD='node'

" }}}

" CTags {{{

set tags=./tags;$HOME " collect all tags up to the home directory
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" }}}

" Make a dir if no exists {{{

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" }}}

" Backups {{{

set backup
set noswapfile
set backupdir=$HOME/.vim/tmp/backup/
set undodir=$HOME/.vim/tmp/undo/
set directory=$HOME/.vim/tmp/swap/
set viminfo+=n$HOME/.vim/tmp/viminfo

" make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)

" }}}

" Colorscheme {{{

syntax enable                  " enable the syntax highlight
set background=dark            " set a dark background
set t_Co=256                   " 256 colors for the terminal
" let base16colorspace=256       " Access colors present in 256 colorspace

" }}}

" QuickFix/Location file nav {{{

" next and prev in location file
map <F4> :lnext<CR>
map <S-F4> :lprevious<CR>

" next and prev in quickfix
map <F5> :cnext<CR>
map <S-F5> :cprevious<CR>

" }}}

" Font {{{

set guifont=Sauce\ Code\ Powerline\ Light:h15

" }}}

" Clipboard {{{

" make clipboard work with std clipboard
" Note that X11 uses the plus register for
" std clipboard, not the * as Mac os or windows
set clipboard+=unnamedplus

" }}}

" Show hidden chars {{{

nmap <Leader>eh :set list!<CR>
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶

" }}}

" Remember last location in file {{{

augroup last_au
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
augroup END

" }}}

" Autoload configuration when this file changes ($MYVIMRC) {{{

augroup vimrc_au
  autocmd!
  autocmd! BufWritePost vimrc source %
augroup END

" }}}

" Toggle line numbers {{{

nnoremap <silent><Leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if !&number && !&relativenumber
      set number
      set norelativenumber
  elseif &number && !&relativenumber
      set nonumber
      set relativenumber
  elseif !&number && &relativenumber
      set number
      set relativenumber
  elseif &number && &relativenumber
      set nonumber
      set norelativenumber
  endif
endfunction

" }}}

" Save as root {{{

cnoremap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" Load matchit by default {{{

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}

" remove trailing white space on save {{{

augroup remove_trailing_au
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" }}}

" make and python use real tabs {{{

augroup keep_tab_au
  autocmd!
  autocmd FileType make set noexpandtab
  autocmd FileType python set noexpandtab
augroup END

" }}}

" Use 4 tabs for CPP {{{

augroup CPP_indent
  autocmd!
  autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END

"}}}

" Conceal to hide some part of the text {{{

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" }}}

" Fix terminal timeout when pressing escape {{{
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" Include user's local vim config {{{
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" }}}

" END VIM SETUP }}}

" NeoBundle auto-installation and setup {{{

" Auto installing NeoBundle
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif
let g:neobundle#install_process_timeout = 600


" Call NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

call neobundle#end()

" BUNDLES (plugins administrated by NeoBundle) {{{

" ultisnips {{{
NeoBundle 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = [ "ultisnips" ]
" }}}

" You complete me {{{

NeoBundle 'Valloric/YouCompleteMe' , {
           \ 'build' : {
           \    'unix' : './install.sh --system-libclang',
           \    'mac' : './install.sh'
           \ },
\ }

let g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" Play nice with iterm2 + tmux {{{

" Changing cursor shape per mode
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[5 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[1 q\<Esc>\\"
else
    let &t_SI .= "\<Esc>[5 q"
    let &t_EI .= "\<Esc>[1 q"
endif

" }}}

" JavaScript {{{

" JavaScript
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" JS Beautifier {{{

NeoBundle 'maksimr/vim-jsbeautify'
augroup JsBeautify_au
  autocmd!
  " Beautifier
  autocmd FileType javascript noremap <buffer> ff :call JsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> ff :call HtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> ff :call CSSBeautify()<cr>
augroup END

" }}}

NeoBundle 'lukaszb/vim-web-indent'
NeoBundle 'pangloss/vim-javascript'

" Tern code analysis for JS
NeoBundle 'marijnh/tern_for_vim', {
      \ 'build' : {
      \     'mac' : 'npm install',
      \     'unix' : 'npm install',
      \    },
      \ }
" }}}


" html/CSS/handlebars {{{

" Markdown  {{{

augroup markdown_md
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

" }}}
"
" Handlebars  {{{

NeoBundle 'mustache/vim-mustache-handlebars'
augroup handlebars_au
  autocmd!
  autocmd BufNewFile,BufRead *.hb set filetype=html syntax=mustache
augroup END

" }}}

" HTML5 + inline SVG omnicomplete funtion, indent and syntax
NeoBundleLazy 'othree/html5.vim', {'autoload':
            \ {'filetypes': ['html', 'xhtml', 'css']}}

" }}}


" Text edition {{{

" similar to f, but instead of one it expects two characters
NeoBundle 'goldfeld/vim-seek'
" multiple cursors like sublime text
NeoBundle 'terryma/vim-multiple-cursors'
" to surround vim objects with a pair of identical chars
NeoBundle 'tpope/vim-surround'
" abolish.vim: easily search for, substitute, and abbreviate multiple variants of a word
NeoBundle 'tpope/vim-abolish'
" extend repetitions by the 'dot' key
NeoBundle 'tpope/vim-repeat'
" toggle comments
NeoBundle 'tpope/vim-commentary'
" Safe past mode
NeoBundle 'ConradIrwin/vim-bracketed-paste'
" Set working dir to root of project (.git)
NeoBundle 'airblade/vim-rooter'
" replace in quickfix
NeoBundle 'thinca/vim-qfreplace'
" Autocompletion of (, [, {, ', ", ... {{{
NeoBundle 'delimitMate.vim'
let delimitMate_expand_cr = 2
" Ag
NeoBundle 'rking/ag.vim'
nmap <Leader>a :Ag<space>''<left>
" quickfix do (Cdo) / location do (Ldo)
NeoBundle 'Peeja/vim-cdo'
" }}}

" }}}

" GUI {{{

" color scheme
NeoBundle 'chriskempson/base16-vim'
colorscheme base16-monokai

" Status bar {{{ -------------------------------------------------------------
" awesome command line
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|undotree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|undotree' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \ '' != expand('%:t') ? expand('%:h:t') . '/' . expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|undotree' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" }}}

" undotree {{{

" browse the vim undo tree

NeoBundleLazy 'mbbill/undotree', { 'autoload' : {'commands': 'UndotreeToggle'}}
nnoremap <F6> :UndotreeToggle<CR>

" }}}

" winresizer {{{

" easily window resizing
NeoBundle 'jimsei/winresizer'

let g:winresizer_start_key = '<C-C><C-W>'

" }}}

" NERDTree configuration {{{

NeoBundle 'scrooloose/nerdtree'
map <Leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
augroup nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q
augroup END

" }}}


" Git {{{

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mhinz/vim-signify'  " Add +/- in gutter bar when file is changed

" }}}


" Syntax {{{

" Neomake {{{

NeoBundle 'benekastah/neomake'

augroup Neomake
  autocmd!
  autocmd BufWritePost * Neomake
augroup END

" }}}

" Syntax complete {{{

" load syntax file as omnicomplete when there is no omnicompletion fn
NeoBundle 'vim-scripts/SyntaxComplete'
augroup SyntaxComplete_au
  autocmd!
  autocmd Filetype *
          \ if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
augroup END

setlocal omnifunc=syntaxcomplete#Complete

" }}}
" JSON
NeoBundle 'elzr/vim-json'

let g:vim_json_syntax_conceal = 0
augroup JSON
  autocmd!
  autocmd BufNewFile,BufRead *.json set ft=json
augroup END

" color scheme for less

NeoBundleLazy 'groenewege/vim-less', {'filetypes' : 'less'}

" }}}
" color scheme for sass

NeoBundle 'tpope/vim-haml'

" }}}

"

" Auto install the plugins {{{

" First-time plugins installation
if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :NeoBundleInstall
endif


" Check if all of the plugins are already installed, in other case ask if we
" want to install them (useful to add plugins in the .vimrc)
NeoBundleCheck

" }}}

filetype plugin indent on      " Indent and plugins by filetype

" END BUNDLES }}}


" vim:foldmethod=marker:foldlevel=3:foldenable
