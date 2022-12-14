local M = {}

function M.setup()
    local whichkey = require "which-key"

    local conf = {
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
    }

    local keymaps_f = {
        name = "Find",
        f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
        d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
        g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        r = { "<cmd>Telescope file_browser<cr>", "Browser" },
        w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
    }

    local keymaps_p = {
        name = "Project",
        p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
        s = { "<cmd>Telescope repo list<cr>", "Search" },
        o = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    }

    local opts = {
        mode = "n", -- Normal mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
    }

    local v_opts = {
        mode = "v", -- Visual mode
        prefix = "<leader>",
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
    }

    local mappings = {
        ["w"] = { "<cmd>update!<CR>", "Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" },

        b = {
            name = "Buffer",
            c = { "<Cmd>bd!<Cr>", "Close current buffer" },
            D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
        },

        z = {
            name = "Packer",
            c = { "<cmd>PackerCompile<cr>", "Compile" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            s = { "<cmd>PackerSync<cr>", "Sync" },
            S = { "<cmd>PackerStatus<cr>", "Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update" },
        },

        g = {
            name = "Git",
            s = { "<cmd>Neogit<CR>", "Status" },
        },

        n = {
            name = "Generator",
            n = { "<cmd>Neogen file<cr>", "File Doc" },
            c = { "<cmd>Neogen class<cr>", "Class Doc" },
            f = { "<cmd>Neogen func<cr>", "Func Doc" },
            t = { "<cmd>Neogen type<cr>", "Type Doc" },
            d = { "<cmd>DogeGenerate<cr>", "Generate Doc" },
        },

        -- f = {
        --   name = "Find",
        --   f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
        --   b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
        --   o = { "<cmd>FzfLua oldfiles<cr>", "Old files" },
        --   g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
        --   c = { "<cmd>FzfLua commands<cr>", "Commands" },
        -- },

        f = keymaps_f,
        p = keymaps_p,
    }

    local v_mappings = {
        n = {
            name = "AI Codex",
            g = { "<cmd>lua require'utils.codex'.complete()<cr>", "AI - Generate Codes" },
        },
    }

    whichkey.setup(conf)
    whichkey.register(mappings, opts)
    whichkey.register(v_mappings, v_opts)
end

return M
