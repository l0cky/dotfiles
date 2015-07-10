" If the system is Windows
" let the runtimepath .vim folder in  user $HOME folder
let &rtp='$HOME/.vim'.','.&rtp

" If the system is Linux
" Install the vim-plug if it doesn't exist
if has("unix")
    if empty(glob('$HOME/.vim/autoload/plug.vim'))
        silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
endif

" vim-plug config
call plug#begin('$HOME/.vim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': 'yes \| ./install' }

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Colorschemes {
Plug 'nanotech/jellybeans.vim'
Plug 'vim-scripts/EditPlus'
Plug 'vim-scripts/xoria256.vim'
"}

" Goyo.vim, clear the window look {
Plug 'junegunn/goyo.vim'
"}

" Editorconfig {
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
"}

" Windows-on full screen,
Plug 'xolox/vim-shell', {'on': [] } | Plug 'xolox/vim-misc', {'on': [] }
"}

" Status line {
    " Vim-airline {
"   Plug 'bling/vim-airline'

    " Lightline
    Plug 'itchyny/lightline.vim'

" Vim-fugitive - Git wrapper
Plug 'tpope/vim-fugitive'

call plug#end()

" Functions {
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" EnsureDirExists
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo "Created directory: " . a:dir
    else
      echo "Please create directory: " . a:dir
    endif
  endif
endfunction

"}

" Basic {
set nocompatible    " use vim default
filetype plugin indent on
syntax enable           " Enable synatx highlighting
syntax on
scriptencoding utf-8
set encoding=utf-8  " use utf-8 encoding

try                 " A magyar nyelv beállítása ha lehetséges
    lang hu_HU
catch
endtry

set ls=2            " always show status line
set t_Co=256
colorscheme jellybeans
"set background=dark
"highlight Normal guibg=black guifg=white
" }

set number relativenumber
set smarttab
"    set expandtab
set autoindent                      " autoindent when starting new line or using 'o' or 'O'
set smartindent
set backspace=indent,eol,start      " allow backscape in insert mode
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowrap
set ignorecase
set smartcase
set incsearch
set hlsearch
set scrolloff=5
set cursorline

set list
set listchars=trail:·,tab:»\ ,eol:¬
highlight NonText guifg=#696969
highlight NonText guibg=#222222
highlight SpecialKey guifg=#696969
highlight SpecialKey guibg=#222222

set wildmenu
set backup
set undofile

call EnsureDirExists($HOME . '/.vim/vimswap')
set directory=~/.vim/vimswap

call EnsureDirExists($HOME . '/.vim/vimbackup')
set backupdir=~/.vim/vimbackup

call EnsureDirExists($HOME . '/.vim/vimundo')
set undodir=~/.vim/vimundo

set laststatus=2


if has("win32")
    call plug#load('vim-misc', 'vim-shell')
endif


" GUI options {
if has("gui_running")
    set guioptions-=m    " remove menu bar
    set guioptions-=T    " remove toolbar
    set guioptions-=r    " remove right-hand scroll bar
    set guioptions-=L    " remove left-hand scroll bar
"	set background=dark
"	highlight Normal guibg=black guifg=white
"    let &guifont = "DejaVu Sans Mono for Powerline:h12" " beállítja ezt a betűtípust és méretet
    if has('gui_win32')                    " Ha Windowson futó grafikus felület esetén
        let &guifont = "DejaVu Sans Mono for Powerline:h12" " beállítja ezt a betűtípust és méretet
        au GUIEnter * simalt ~m              " Maximalizálva induljon az ablak
    endif
   endif
" }

" Vim-airline config {
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"      let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
"  let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_theme = 'jellybeans'
" }

let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'modified': 'MyModified',
    \   'filename': 'MyFilename'
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
" }

" Mapping {
" Strip Trailing Whitespaces
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
nmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>P "+P

nmap <Leader><Leader> V
" }
"
" Specials {
" Strip Trailing Whitespaces
augroup StripTrailingWhitespaces
    autocmd!
    autocmd BufWritePre *.html,*.php,*.css,*.js :call <SID>StripTrailingWhitespaces()
augroup END

" html
augroup html
    autocmd!
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" CSS
augroup CSS
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" Javascript
augroup javascript
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
augroup END
" }

" Functions
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
    if has("unix")
      if system('uname')=~'Darwin'
        return "mac"
      else
        return "linux"
      endif
    endif
  endfunction
  let os=GetRunningOS()

" Reload vimrc {
augroup reload_vimrc
  if os =~ 'win'
    autocmd!
    autocmd bufwritepost $HOME/_vimrc nested source %  " When vimrc is editied, reload it
    set nobackup                                  " Don't make backups
  elseif os =~ 'linux'
    autocmd!
    autocmd bufwritepost .vimrc nested source %         " When vimrc is editied, reload it
    set nobackup                                  " Don't make backups
  endif
augroup END
" }

