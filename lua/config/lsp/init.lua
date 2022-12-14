local M = {}

local servers = {
    -- gopls = {},
    html = {},
    jsonls = {},
    pyright = {},
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = {
                    command = "cargo clippy",
                    extraArgs = { "--no-deps" },
                },
                -- cmd = {
                --     "rustup", "run", "nightly", "rust-analyzer"
                -- }
            },
        },
    },
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins", "MiniTest" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    },
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
            },
        },
    },
    tsserver = {},
    vimls = {},
    yamlls = {},
    dockerls = {},
    bashls = {},
    taplo = {},
}

local function on_attach(client, bufnr)
    -- Enable completion triggered by <C-X><C-O>
    -- See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Use LSP as the handler for formatexpr.
    -- See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Configure key mappings
    require("config.lsp.keymaps").setup(client, bufnr)

    -- Configure formatting
    require("config.lsp.null-ls.formatters").setup(client, bufnr)
end

-- local lsp_signature = require "lsp_signature"
-- lsp_signature.setup {
--   bind = true,
--   handler_opts = {
--     border = "rounded",
--   },
-- }

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
    -- null-ls
    require("config.lsp.null-ls").setup(opts)

    -- Installer
    require("config.lsp.installer").setup(servers, opts)
end

return M
