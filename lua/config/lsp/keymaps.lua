local M = {}

local whichkey = require "which-key"

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Key mappings
    buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
    keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

    -- Whichkey
    local keymap_l = {
        l = {
            name = "Code",
            R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
            a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
            d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
            f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
            i = { "<cmd>LspInfo<CR>", "Lsp Info" },
            n = { "<cmd>Lspsaga rename<CR>", "Rename" },
            r = { "<cmd>Telescope lsp_references<CR>", "Diagnostics" },
            s = { "<cmd>Telescope lsp_document_symbols<CR>", "Diagnostics" },
            t = { "<cmd>TroubleToggle<CR>", "Trouble" },
            l = { "<cmd>lua require('config.lsp.null-ls.formatters').toggle()<cr>", "Toggle Autoformat"},
            k = { "<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<cr>", "Apply Autoformat"}
        },
    }

    if client.server_capabilities.document_formatting then
        keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
    end

    local keymap_g = {
        name = "Goto",
        d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
    }
    whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
    whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

function M.setup(client, bufnr)
    keymappings(client, bufnr)
end

return M
