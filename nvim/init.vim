" {{{ PLUGINS

call plug#begin("~/.config/nvim/plugged")

" color
Plug 'navarasu/onedark.nvim'

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" Plug 'nvim-treesitter/playground'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" indents
Plug 'lukas-reineke/indent-blankline.nvim'

" lualine and tabline
Plug 'hbodas/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" utility
Plug 'jghauser/mkdir.nvim'
Plug 'preservim/nerdcommenter'

" autocomplete
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" LSP stuff
Plug 'neovim/nvim-lspconfig'

" rust
" use 'simrat39/rust-tools.nvim'

" splitting stuff
Plug 'Wansmer/treesj'

" surround
Plug 'kylechui/nvim-surround'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'

" misc language support
" Plug 'elkowar/yuck.vim'

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
set shiftwidth=2
set tabstop=2
set softtabstop=2

" augroup Filetype
  " autocmd!
  " autocmd Filetype rust setlocal shiftwidth=4 tabstop=4 softtabstop=4
" augroup END

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

" {{{ PLUGINS

lua << EOF

-- {{{ NVIM-TREESITTER
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "javascript", "typescript", "python" },

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
-- }}}

-- {{{ INDENT BLANKLINE
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
}
-- }}}

-- {{{ LUALINE
require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = '|',
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = { { 'location', separator = {right  = '' }, left_padding = 2 }},
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = {
      { 
          'tabs', 
          mode = 2 ,
          max_length = vim.o.columns/2,
          separator = { left = '',  right = ''}, 
          right_padding = 2 ,
          fmt = function(name, context)
            -- Show + if buffer is modified in tab
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, '&mod')

            return name .. (mod == 1 and ' +' or '')
          end
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { 'buffers', separator = { left = '', right  = '' } } },
  },
  extensions = {},
}
-- }}}

-- {{{ TREESJ
require('treesj').setup {
    use_default_keymaps = false,
    max_join_length = 1000,
}
-- }}}

-- {{{ NVIM SURROUND
require('nvim-surround').setup {}
-- }}}

-- {{{ LSPCONFIG - RUST ANALYZER
require('./lsp.lua')
-- }}}

-- {{{ TELESCOPE
require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,

    -- mappings = {
    --   i = {
    --     ["C-j"] = "telescope.actions.move_selection_next",
    --     ["C-k"] = "telescope.actions.move_selection_previous"
    --   }
    -- }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
-- }}}

-- {{{ ONEDARK
require('onedark').setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = false,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
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

" " Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
" inoremap <silent><expr> <c-j>
      " \ coc#pum#visible() ? coc#pum#next(1) :
      " \ CheckBackspace() ? "\<Tab>" :
      " \ coc#refresh()
" inoremap <expr><c-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>"

" function! CheckBackspace() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion
" if has('nvim')
  " inoremap <silent><expr> <c-space> coc#refresh()
" else
  " inoremap <silent><expr> <c-space> coc#refresh()
" endif

" " code navigation
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
  " autocmd!
  " " Setup formatexpr specified filetype(s)
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder
  " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" " Run the Code Lens action on the current line
" nmap <silent> <leader>gc <Plug>(coc-codelens-action)
" nmap <silent> <leader>ga <Plug>(coc-codeaction)

" " Add `:Format` command to format current buffer
" command! -nargs=0 Format :call CocActionAsync('format')
" augroup Format
  " autocmd!
  " autocmd BufWritePre *.rs,*.py :Format
  " autocmd BufWritePre *.py :call CocAction('runCommand', 'python.sortImports')
" augroup END

" " Add `:OR` command for organize imports of the current buffer
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" " }}}

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















