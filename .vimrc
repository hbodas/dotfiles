
" {{{ PLUGINS
call plug#begin('~/.vim/plug')

" pywal
Plug 'dylanaraps/wal.vim'

" Nerd Commenter
Plug 'scrooloose/nerdcommenter'

" auto origami (fold column)
Plug 'benknoble/vim-auto-origami'

" surround
Plug 'tpope/vim-surround'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe' , {'do': './install.py --clang-completer', 'for' : 'tex'}

" Vimtex
Plug 'lervag/vimtex', {'for' : 'tex'}

" airline
Plug 'vim-airline/vim-airline'

" airline themes
Plug 'vim-airline/vim-airline-themes'

" Ultisnips engine
Plug 'SirVer/ultisnips'

" snippets for ultisnips
Plug 'honza/vim-snippets'

" indent guides
Plug 'nathanaelkane/vim-indent-guides'

" multiple cursors
Plug 'terryma/vim-multiple-cursors'

" tmux-vim-navigation
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
" }}}

" {{{ GENERAL STUFF
" not really useful, but it's just there
set nocompatible
set hidden
set noshowmode

" encoding
set encoding=utf-8

" set colorscheme
syntax enable
colorscheme wal

" filetype plugins
filetype indent on
filetype plugin on

" enable syntax coloring
syntax on

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
set tabstop=8
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab

" backspace works like standard backspace
set backspace=indent,eol,start

" display cursor position at the bottom
set ruler

" always display the status line
set laststatus=2

" raise dialog asking to save changes
set confirm

"show line numbers on the left
set number

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
set viewoptions=folds,cursor,slash,unix
set sessionoptions=folds

" fold method
set foldmethod=marker

" autoload file changes
set autoread

" set split to right and split down
set splitbelow
set splitright

" completion options
set completeopt=menu

" overriding background color
hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE

" clipboard
set clipboard=unnamedplus

" some speedups
set ttyfast
set lazyredraw

" restore cursor position from last time
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
" }}}

" {{{ GLOBAL KEYBINDINGS
" setting a leader
let mapleader= ";"

" sudo save a file
command S w !sudo tee % > /dev/null

" some common mistakes
command W write

" exit insert mode by pressing [;
inoremap wj <Esc>
inoremap jw <Esc>

" spell check set to F6
map <F9> :setlocal spell! spelllang=en_us,es<CR>

" easier navigation between buffers
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>
map <C-L> <C-W><C-L>
map <C-H> <C-W><C-H>

" insert guide for navigation (works only in insert and normal mode)
inoremap ;r <++>
nnoremap ;r i<++><Esc>l

" navigate to next guide
inoremap ;e <Esc>/<++><Enter><Esc>:noh<Enter>4xa
nnoremap ;e /<++><Enter><Esc>:noh<Enter>4xa

" unhighlight, cause it's annoying
nnoremap nh :noh<cr>
" }}}

" {{{ PLUGIN SETTINGS

" {{{ NERDCOMMENTER

" comment empty lines
let g:NERDCommentEmptyLines = 0

" nested comments by defaut
let g:NERDefaultNesting = 1

" one space after comment delims
let g:NERDSpaceDelims = 1

" remove extra space
let g:NERDRemoveExtraSpaces = 1

" remove trailing whitespace
let g:NERDTrimTrailingWhitespace = 1
" }}}

" {{{ VIM-AUTO-ORIGAMI

" function to enable this plugin
augroup autofoldcolumn
  au!

  " Or whatever autocmd-events you want
  au CursorHold,BufWinEnter * let &foldcolumn = auto_origami#Foldcolumn()
augroup END

let g:auto_origami_foldcolumn=0
let g:auto_origami_default=0
" }}}

" {{{ YOU COMPLETE ME

" minimum number of characters to trigger identifier based completer. High value
" to effectively turn it off
let g:ycm_min_num_of_chars_for_completion = 1

" minimum number of characters in suggestions
let g:ycm_min_num_identifier_candidate_chars = 2

" maximum number of candidates settings
let g:ycm_max_num_candidates = 20

" disable filepath completion
let g:ycm_filepath_blacklist = {
      \ 'tex' : 1,
      \ 'bib' : 1
      \ }

" use YCM with tex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
autocmd filetype tex let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" using with python
let g:ycm_python_binary_path = '/usr/bin/python'
" }}}

" {{{ AIRLINE

" use powerline fonts
let g:airline_powerline_fonts = 1

" theme setting
let g:airline_theme = 'wal'

" what sections get truncated and at what width
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 79,
  \ 'x': 60,
  \ 'y': 88,
  \ 'z': 45,
  \ 'warning': 80,
  \ 'error': 80,
  \ }

" ignore empty sections
let g:airline_skip_empty_sections = 1

" ignore if the filetype says utf-8[unix]
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" whitespace detection
let g:airline#extensions#whitespace#enabled = 1

" tabline
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0

" mappings to switch tabs
nmap <leader>l <Plug>AirlineSelectNextTab
nmap <leader>h <Plug>AirlineSelectPrevTab

" fugitive tab
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10

" vimtex
let g:airline#extensions#vimtex#enabled = 0
let g:airline#extensions#vimtex#compiled = "c₁"
let g:airline#extensions#vimtex#continuous = "c"
let g:airline#extensions#vimtex#viewer = "v"
" }}}

" {{{ VIMTEX

augroup tex
    au!

    " latex compilation
    autocmd filetype tex nmap <F5> <plug>(vimtex-view)
    autocmd filetype tex nmap <F8> <plug>(vimtex-clean)
    autocmd filetype tex nmap <F6> <plug>(vimtex-compile)

    " start a vim server
    let serv = v:servername
    if serv == ""
        autocmd BufWinEnter *.tex silent call SServer()
    endif
augroup END

" disable recursive searching for mainfile
let g:vimtex_disable_recursive_main_file_detection = 1

" detect tex files as latex and not plaintex
let g:tex_flavor = 'latex'

" enable folding
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual = 1

" aligning on ampersands
let g:vimtex_indent_on_ampersands = 0

" index mode
let g:vimtex_index_mode = 1

" table of labels
let g:vimtex_labels_enabled = 0

" vimtex view method
let g:vimtex_view_method = 'zathura'

let g:vimtex_fold_types = {
    \   'markers' : {'enabled' : 1}
    \ }
" }}}

" {{{ ULTISNIPS

" defines how edit window is opened
let g:UltiSnipsEditSplit = 'vertical'

" directory with private snippet definitions
let g:UltiSnipsSnippetsDir = "~/.vim/snips"

" search order for snippets
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]

" snippet keybindings (NOTE: THESE SHOULD WORK ONLY IN INSERT MODE)
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-k>'
let g:UltiSnipsJumpBackwardTrigger = '<C-l>'

" view snippets
let g:UltiSnipsListSnippets = '<C-v>'
" }}}

" {{{ VIM-INDENT-GUIDES

" guide width
let g:indent_guides_guide_size = 1

" guide start level
let g:indent_guides_start_level = 2

" enable plugin on vim startup
let g:indent_guides_enable_on_vim_startup = 0

" set the indent guide colors
hi IndentGuidesOdd  ctermbg=8
hi IndentGuidesEven ctermbg=8
" }}}

" }}}

" {{{ FUNCTIONS

" trim whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

:noremap <F4> :call TrimWhitespace()<CR>

" servers for tex
fun! SServer()
    let serv=v:servername
    if serv == ''
        call remote_startserver('tex')
    endif
endfun

" }}}
