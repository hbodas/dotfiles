" {{{ PLUGINS

call plug#begin()

" color
" Plug 'rktjmp/lush.nvim'
" Plug 'rktjmp/shipwright.nvim'
" Plug 'sainnhe/sonokai'
" Plug 'oncomouse/lushwal.nvim'
" Plug 'ray-x/starry.nvim'
" Plug 'Everblush/nvim', { 'as' : 'everblush' }
" Plug 'morhetz/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'marko-cerovac/material.nvim'
Plug 'nxvu699134/vn-night.nvim'

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Plug 'nvim-treesitter/playground'
" Plug 'AckslD/nvim-trevJ.lua'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" indents
Plug 'lukas-reineke/indent-blankline.nvim'

" lualine and tabline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kdheepak/tabline.nvim'

" utility
Plug 'jghauser/mkdir.nvim'
Plug 'preservim/nerdcommenter'
"
" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" splitting stuff
Plug 'Wansmer/treesj'

call plug#end()

" }}}

" {{{ GENERAL STUFF

" remember cursor position
augroup vimrc_remember_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! zz`\"" | endif
augroup END


" colors
syntax enable
" set termguicolor

" gruvbox
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox

" srcery
augroup color_stuff
    autocmd! 
    autocmd ColorScheme * highlight Folded guibg=None ctermbg=None
augroup END
colorscheme vn-night

" filetype
filetype plugin on 
filetype indent on

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
" set cursorline

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

" {{{ PLUGINS

lua << EOF

-- {{{ NVIM-TREESITTER
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
    "c",
    "lua",
    "javascript",
    "typescript",
    "python",
    "help",
    "bash",
    "gitcommit",
    "gitattributes",
    "gitignore",
    "go",
    "gomod",
    "json",
    "latex",
    "ocaml",
    "vim",
    "rust",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "help" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- temp stuff
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}


require('nvim-treesitter.configs').setup {
  refactor = {
    highlight_definitions = {

      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },

    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "gn",
      },
      -- others in the coc section
    },
  },
}
-- }}}

-- {{{ INDENT_BLANKLINE
-- indent or something
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
}
-- }}}

--{{{ LUALINE
-- indent or something
require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = '|',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
-- }}}

-- {{{ TABLINE 
require('tabline').setup {
    options = {
        show_tabs_only = true,
    }
}
-- }}}

-- {{{ TREESJ
require('treesj').setup {
    use_default_keymaps = false,
    max_join_length = 1000,
}
-- }}}

EOF

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

" {{{ COC


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <c-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><c-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<Tab>\<c-r>=coc#on_enter()\<Tab>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-space> coc#refresh()
endif

" code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" }}}

" {{{ TREESJ

" some keybinds
nmap <leader>st :TSJToggle<CR>
nmap <leader>sp :TSJSplit<CR>
nmap <leader>sj :TSJJoin<CR>

" }}}

" }}}
