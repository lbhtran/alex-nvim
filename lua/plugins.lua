local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        profile = {
            enable = true,
            threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    -- Plugins
    local function plugins(use)
        use { "wbthomason/packer.nvim" }

        -- Colorscheme
        use {
            "folke/tokyonight.nvim",
            config = function()
                vim.cmd "colorscheme tokyonight"
            end,
        }

        -- Startup screen
        use {
            "goolord/alpha-nvim",
            config = function()
                require("config.alpha").setup()
            end,
        }

        -- Load only when require
        use { "nvim-lua/plenary.nvim", module = "plenary" }

        -- Better icons
        use {
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup { default = true }
            end,
        }

        -- Better Comment
        use {
            "numToStr/Comment.nvim",
            opt = true,
            keys = { "gc", "gcc", "gbc" },
            config = function()
                require("Comment").setup {}
            end,
        }

        -- Easy hopping
        use {
            "phaazon/hop.nvim",
            cmd = { "HopWord", "HopChar1" },
            config = function()
                require("hop").setup {}
            end,
        }

        -- Easy motion
        use {
            "ggandor/lightspeed.nvim",
            keys = { "s", "S", "f", "F", "t", "T" },
            config = function()
                require("lightspeed").setup {}
            end,
        }

        -- Markdown
        use {
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            ft = "markdown",
            cmd = { "MarkdownPreview" },
        }

        -- Autosave
        use {
            "Pocco81/auto-save.nvim",
            config = function()
                require("auto-save").setup {}
            end,
        }

        -- Git
        use {
            "TimUntersberger/neogit",
            cmd = "Neogit",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("config.neogit").setup()
            end,
        }

        -- Gitsign
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            wants = "plenary.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("config.gitsigns").setup()
            end,
        }

        -- Documentation - Neogen
        use {
            "danymat/neogen",
            cmd = "Neogen",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function()
                require("config.neogen").setup()
            end,
            module = "neogen",
            disable = false,
        }

        -- Documentation - Neogen
        use {
            "kkoomen/vim-doge",
            run = ":call doge#install()",
            config = function()
                require("config.doge").setup()
            end,
            cmd = { "DogeGenerate", "DogeCreateDocStandard" },
            disable = false,
        }

        -- WhichKey
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function()
                require("config.whichkey").setup()
            end,
        }

        -- IndentLine
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            config = function()
                require("config.indentblankline").setup()
            end,
        }

        -- Lualine
        use {
            "nvim-lualine/lualine.nvim",
            event = "VimEnter",
            config = function()
                require("config.lualine").setup()
            end,
            requires = { "nvim-web-devicons" },
        }

        -- Nvim GPS
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter",
            module = "nvim-gps",
            config = function()
                require("nvim-gps").setup()
            end,
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end,
        }

        -- Fuzzy search - fzf
        -- use { "junegunn/fzf", run = "./install --all" }
        -- use {
        --  "ibhagwan/fzf-lua",
        --   requires = { "kyazdani42/nvim-web-devicons" },
        -- }

        -- nvim-tree
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons",
            },
            --event = "VimEnter",
            -- cmd = { "NvimTreeToggle", "NvimTreeClose" },
            config = function()
                require("config.nvimtree").setup()
            end,
        }

        -- Buffer line
        --use {
        --"akinsho/nvim-bufferline.lua",
        --event = "BufReadPre",
        --wants = "nvim-web-devicons",
        --config = function()
        --require("config.bufferline").setup()
        --end,
        --}

        -- nvim-cmp
        use {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            opt = true,
            config = function()
                require("config.cmp").setup()
            end,
            wants = { "LuaSnip" },
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-calc",
                "f3fora/cmp-spell",
                "hrsh7th/cmp-emoji",
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    config = function()
                        require("config.luasnip").setup()
                    end,
                },
                "rafamadriz/friendly-snippets",
                disable = false,
            },
        }

        -- Auto pairs
        use {
            "windwp/nvim-autopairs",
            wants = "nvim-treesitter",
            module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
            config = function()
                require("config.autopairs").setup()
            end,
        }

        -- Auto tag
        use {
            "windwp/nvim-ts-autotag",
            wants = "nvim-treesitter",
            event = "InsertEnter",
            config = function()
                require("nvim-ts-autotag").setup { enable = true }
            end,
        }

        -- End wise
        use {
            "RRethy/nvim-treesitter-endwise",
            wants = "nvim-treesitter",
            event = "InsertEnter",
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            opt = true,
            event = "BufReadPre",
            -- wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim", "neodev.nvim" },
            wants = {
                "cmp-nvim-lsp",
                "mason.nvim",
                "mason-lspconfig.nvim",
                "mason-tool-installer.nvim",
                "neodev.nvim",
                "null-ls.nvim",
            },
            config = function()
                require("config.lsp").setup()
            end,
            requires = {
                "williamboman/nvim-lsp-installer",
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                "jose-elias-alvarez/null-ls.nvim",
                -- "ray-x/lsp_signature.nvim",
                "folke/neodev.nvim",
                {
                    "j-hui/fidget.nvim",
                    config = function()
                        require("fidget").setup {}
                    end,
                },
            },
        }

        -- Rust
        use {
            "simrat39/rust-tools.nvim",
            requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
            module = "rust-tools",
            ft = { "rust" },
            config = function()
                require("rust-tools").setup {}
            end,
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            opt = true,
            config = function()
                require("config.telescope").setup()
            end,
            cmd = { "Telescope" },
            module = "telescope",
            keys = { "<leader>f", "<leader>p" },
            wants = {
                "plenary.nvim",
                "popup.nvim",
                "telescope-fzf-native.nvim",
                "telescope-project.nvim",
                "telescope-repo.nvim",
                "telescope-file-browser.nvim",
                "project.nvim",
            },
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                "nvim-telescope/telescope-project.nvim",
                "cljoly/telescope-repo.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
                {
                    "ahmedkhalf/project.nvim",
                    config = function()
                        require("project_nvim").setup {}
                    end,
                },
            },
        }
        -- trouble.nvim
        use {
            "folke/trouble.nvim",
            event = "BufReadPre",
            wants = "nvim-web-devicons",
            cmd = { "TroubleToggle", "Trouble" },
            config = function()
                require("trouble").setup {
                    use_diagnostic_signs = true,
                }
            end,
        }

        -- lspsaga.nvim
        use {
            "tami5/lspsaga.nvim",
            event = "VimEnter",
            cmd = { "Lspsaga" },
            config = function()
                require("lspsaga").setup {}
            end,
        }

        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)
end

return M
