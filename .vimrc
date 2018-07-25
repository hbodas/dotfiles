" Author: Hrishikesh Bodas
" Last edited July 4, 2018

" PLUGIN

call plug#begin('~/.vim/plug')

" Nerd Commenter
Plug 'scrooloose/nerdcommenter'

" auto origami (fold column)
Plug 'benknoble/vim-auto-origami'

" surround
Plug 'tpope/vim-surround'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}

" airline
Plug 'vim-airline/vim-airline'

" airline themes
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" GENERAL

" encoding
set encoding=utf-8

" set colorscheme
syntax enable
set background=dark
colorscheme gruvbox

" filetype plugins
filetype indent on
filetype plugin on

" enable syntax coloring
syntax on

" not really useful, but it's just there
set nocompatible
set hidden

" better command jine completion
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

" viewoptions
set viewoptions=folds,cursor
set sessionoptions=folds

" restore folds upon save and reload
augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent loadview
augroup end

" autoload file changes
set autoread

" set split to right and split down
set splitbelow
set splitright

" GLOBAL KEYBINDINGS

" setting a leader
let mapleader= ";"

" sudo save a file
command W w !sudo tee % > /dev/null

" exit insert mode by pressing [;
inoremap wj <Esc>
inoremap jw <Esc>

" spell check set to F6
map <F6> :setlocal spell! spelllang=en_us,es<CR>

" easier navigation between buffers
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>
map <C-L> <C-W><C-L>
map <C-H> <C-W><C-H>

" insert guide for navigation (works only in insert and normal mode)
inoremap ;w <++>
nnoremap ;w i<++><Esc>l

" navigate to next guide
inoremap ;e <Esc>/<++><Enter><Esc>:noh<Enter>4xi
nnoremap ;e /<++><Enter><Esc>:noh<Enter>4xi


" PLUGIN SETTINGS

" NERDCOMMENTER

" comment empty lines
let g:NERDCommentEmptyLines = 1

" nested comments by defaut
let g:NERDefaultNesting = 1

" one space after comment delims
let g:NERDSpaceDelims = 1

" remove extra space
let g:NERDRemoveExtraSpaces = 1

" remove trailing whitespace
let g:NERDTrimTrailingWhitespace = 1

" VIM-AUTO-ORIGAMI

" function to enable this plugin
augroup autofoldcolumn
  au!

  " Or whatever autocmd-events you want
  au CursorHold,BufWinEnter * let &foldcolumn = auto_origami#Foldcolumn()
augroup END

" YOU COMPLETE ME

" minimum number of characters to trigger plugin
let g:ycm_min_num_of_chars_for_completion = 1

" minimum number of characters in suggestions
let g:ycm_min_num_identifier_candidate_chars = 3

" maximum number of candidates settings
let g:ycm_max_num_candidates = 20
let g:ycm_max_num_identifier_candidates = 10

" filetype blacklist
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'tex': 1,
      \ 'bib': 1
      \}

" AIRLINE

" use powerline fonts
let g:airline_powerline_fonts = 1

" theme setting
let g:airline_theme = 'simple'

" what sections get truncated and at what width
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 79,
  \ 'x': 60,
  \ 'y': 88,
  \ 'z': 45,
  \ 'warning': 80,
  \ 'error': 80,
  \ }

" ignore if the filetype says utf-8[unix]
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" tabline
let g:airline#extensions#tabline#enabled = 1

" fugitive tab
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10

" vimtex
let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#vimtex#compiled = "c₁"
let g:airline#extensions#vimtex#continuous = "c"
let g:airline#extensions#vimtex#viewer = "v"


" FUNCTIONS

" trim whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

:noremap <F4> :call TrimWhitespace()<CR>

