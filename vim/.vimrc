"
" Vundle Settings
"

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"
Bundle "scrooloose/nerdtree"
Bundle "mileszs/ack.vim"
Bundle "tpope/vim-fugitive"
Bundle "kien/ctrlp.vim"
Bundle "ervandew/supertab"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "vim-ruby/vim-ruby"
Bundle "jnwhiteh/vim-golang"
Bundle "tpope/vim-haml"
Bundle "othree/html5.vim"
Bundle "kchmck/vim-coffee-script"
Bundle "pangloss/vim-javascript"
Bundle "plasticboy/vim-markdown"

set nocompatible
syntax enable
filetype plugin indent on


"
" VIM Settings
"

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight the line of the cursor.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set noswapfile                    " Disable .swp file creation.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.

set history=1000                  " Remember last 1000 commands.
set undolevels=1000               " Remember last 1000 undos.
set wildignore=*.swp,*.swo,*.bak,*.class,*.lock

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs.

set laststatus=2                  " Show the status line all the time.
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P " Useful status information at bottom of screen.

set encoding=utf-8                " Default encoding: UTF-8.
set clipboard=unnamed             " Enable OS clipboard to properly paste in to VIM buffer.

colorscheme jellybeans            " Default color scheme (for both Terminal and GUI VIM).

" Flag the following files as Ruby:
autocmd BufRead,BufNewFile {Rakefile,Gemfile,config.ru,Vagrantfile,Thorfile} set ft=ruby

" Flag the following files as HTML:
autocmd BufRead,BufNewFile {*.eco} set ft=html

" Remove trailing whitespace before writing buffer to file.
autocmd BufWritePre * :%s/\s\+$//e

" Change the default leader key from \ to ,.
let mapleader = ","

" Tell ConqueTerm to read from buffer even if you're not in insert mode in
" that VIM window.
let g:ConqueTerm_ReadUnfocused = 1

" Tell CtrlP to always use the base directory that VIM initialized with
" as the starting point for finding files, rather than scoping it down to the
" current buffer's directory level.
let g:ctrlp_working_path_mode = 0


"
" Custom Functions
"

function IndentHash()
  '<,'>Tabularize /:\zs
endfunction
function IndentRocket()
  '<,'>Tabularize /^[^=>]*\zs=>/l1
endfunction
function IndentEquals()
  '<,'>Tabularize /=
endfunction


"
" Custom Mappings
"

map <Leader>i= :call IndentEquals()<cr>
map <Leader>ih :call IndentHash()<cr>
map <Leader>ir :call IndentRocket()<cr>
map <A-Tab> :tabNext<cr>

vmap > >gv                          " Enable easy indenting
vmap < <gv                          " Enable easy outdenting

nmap <S-T>o :NERDTree<Enter>        " SHIFT-T+o to open NERDTree
nmap <S-T>c :NERDTreeClose<Enter>   " SHIFT-T+o to close NERDTree
nmap <Tab> <C-w>w                   " Tab to cycle through to windows

