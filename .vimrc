" Last edited July 4, 2018

" PLUGIN

" execute pathogen#infect()

" GENERAL

" set colorscheme
colorscheme papaya_original
set cursorline

" filetype plugins
filetype indent on
filetype plugin on                             

" enable syntax coloring
syntax on        

" not really useful, but it's just there
set nocompatible                            
set hidden                        

" better command line completion
set wildmenu                   

" show partial commands in the bottom line
set showcmd

" search settings
set hlsearch
set ignorecase
set smartcase
set incsearch

" show matching brackets
set showmatch
set mat=2           

" no modelines (does not read the first few lines in a file)
set nomodeline                                 

" indentation options
set autoindent       
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set smartindent

" backspace works like standard backspace
set backspace=indent,eol,start

" display cursor position at the bottom 
set ruler

" always display the status line
set laststatus=2

" raise dialog asking to save changes
set confirm

"show line numbers on the left
set number relativenumber

" number of undo levels
set undolevels=1000

" persistent undo
set undofile
set undodir=~/.vim/undo

" Number of lines around the cursor when moving up and down
set so=10

" line break at 80 characters and wrap
set wrap
set textwidth=80

" restore folds upon save and reload
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview

" GLOBAL KEYBINDINGS

" sudo save a file
command W w !sudo tee % > /dev/null

" exit insert mode by pressing [;
inoremap wj <Esc> 
inoremap jw <Esc>

" spell check set to F6
map <F6> :setlocal spell! spelllang=en_us,es<CR>

" insert guide for navigation (works only in insert and normal mode)
inoremap ;w <++>
nnoremap ;w i<++><Esc>l

" navigate to next guide
inoremap ;e <Esc>/<++><Enter><Esc>:noh<Enter>4xi
nnoremap ;e /<++><Enter><Esc>:noh<Enter>4xi

