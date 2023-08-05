lua require('plugins.load')

" {{{ GENERAL STUFF

" remember cursor position
augroup vimrc_remember_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! zz`\"" | endif
augroup END

" colors
syntax enable

" gruvbox
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox
" set background='dark'

" colors
colorscheme onedark

" fix some colors
hi Normal guibg=none ctermbg=none
hi LineNr guibg=none ctermbg=none
hi Folded guibg=none ctermbg=none
hi NonText guibg=none ctermbg=none
hi SpecialKey guibg=none ctermbg=none
hi VertSplit guibg=none ctermbg=none
hi SignColumn guibg=none ctermbg=none
hi EndOfBuffer guibg=none ctermbg=none
hi DiagnosticVirtualTextWarn guibg=none ctermbg=none
hi DiagnosticVirtualTextError guibg=none ctermbg=none
hi DiagnosticVirtualTextInfo guibg=none ctermbg=none
hi DiagnosticVirtualTextHint guibg=none ctermbg=none

" filetype
" filetype plugin on
" filetype indent on

" line numbers
set number

" foldmethod
set foldmethod=marker

" some searching stuff
set ignorecase
set smartcase

" show matching parens
set showmatch

" set no modeline
set nomodeline

" tabbing
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" confirm instead of failing
set confirm

" undo 
set undolevels=1000
set undofile
set undodir=~/.nvim/undo

" set scrolloff
set scrolloff=10

" set clipboard
set clipboard+=unnamedplus

" set cursorline
set cursorline

" set autoread
set autoread

" completion stuff
set completeopt=menu,menuone,preview

" set line limits
set textwidth=80

" wrap long lines
set wrap

" make sure that splits are below and right
set splitright
set splitbelow

" }}}

" {{{ KEYBINDS

let mapleader=";"

" sudo save a file
command S w !sudo tee % > /dev/null

" some common mistakes
command W write

" spell check set to F9
map <F9> :setlocal spell! spelllang=en_us,es<CR>

" reload nvim
nnoremap <leader>so :source ~/.config/nvim/init.vim<cr>

" exit insert 
inoremap jw <Esc>
inoremap wj <Esc>

" unhighlight thing
nnoremap nh :noh<cr>

" }}}

" {{{ PLUGIN CONFIGS

lua << EOF

-- lsp stuff
require('plugins.nvim-treesitter')
require('plugins.nvim-lspconfig')
require('plugins.lsp-inlayhints')
require('plugins.nvim-cmp')

-- utility
require('plugins.nvim-surround')
require('plugins.treesj')
require('plugins.telescope')

-- aesthetics
-- require('plugins.indent-blankline')
require('plugins.lualine')
require('plugins.onedark')

EOF

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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

" {{{ TREESJ

" some keybinds
nmap <leader>st :TSJToggle<CR>
nmap <leader>sp :TSJSplit<CR>
nmap <leader>sj :TSJJoin<CR>

" }}}

" {{{ TELESCOPE

" some keybinds

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" }}}

" }}}
