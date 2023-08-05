return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- this is essential.

    -- misc
    use {
        "christoomey/vim-tmux-navigator",
        "jghauser/mkdir.nvim",
    }

    -- lsp and completion and stuff
    use {
        "neovim/nvim-lspconfig",
        "lvimuser/lsp-inlayhints.nvim",

        "SirVer/ultisnips",
        "honza/vim-snippets",
        "quangnguyen30192/cmp-nvim-ultisnips",

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

    }

    -- editor 
    use {
        "preservim/nerdcommenter",
        "kylechui/nvim-surround",
    }

    -- telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "BurntSushi/ripgrep",
            { "nvim-tree/nvim-web-devicons", opt = true },
        }
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim", 
        run = "make",
        requires = {
            "nvim-telescope/telescope.nvim",
        }
    }


    -- treesitter and things
    use {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",

        "Wansmer/treesj",

        run = ":TSUpdate",
    }

    -- Looks
    use {
        "navarasu/onedark.nvim",
        "srcery-colors/srcery-vim",
        -- "lukas-reineke/indent-blankline.nvim",
        "hbodas/lualine.nvim",
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Language support
    use {
        "elkowar/yuck.vim"
    }

end)
