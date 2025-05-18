local servers_dir = "lsp"
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local server_name = client.config.name

        local server_dir = servers_dir .. "." .. server_name
        local conf_ok, conf = pcall(require, server_dir)
        if conf_ok then
            client.filetypes = conf.filetypes or {}
            client.settings = conf.settings or {}
        end

        -- LSP key bindings
        local keybinds = require "config.keybinds"
        for _, km in ipairs(keybinds.lsp) do
            vim.keymap.set(
                km.mode,
                km.keymap,
                km.action,
                { buffer = event.buf, noremap = true, silent = true, desc = "[LSP]: " .. km.desc }
            )
        end

        -- Format on save
        if server_name == "ts_ls" then
            vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = event.buf,
                callback = function()
                    local filepath = vim.fn.expand("%:p")
                    vim.fn.jobstart({ "prettier", "--write", filepath }, {
                        on_exit = function()
                            -- Reload the buffer to show formatting changes
                            vim.cmd("checktime")
                        end
                    })
                end
            })
        else
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format {
                        filter = function(c) return c.name ~= "ts_ls" end
                    }
                end,
            })
        end
    end
})

local icons = require "config.icons"
return {
    {
        "neovim/nvim-lspconfig",
        event = { "VeryLazy" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "mason-org/mason.nvim",           event = "VeryLazy" },
            { "mason-org/mason-lspconfig.nvim", event = "VeryLazy" },
        },
        config = function()
            local cmp_nvim_lsp = require "cmp_nvim_lsp"
            local mason = require "mason"
            local mason_lsp = require "mason-lspconfig"

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

            mason.setup {}
            mason_lsp.setup {}

            vim.diagnostic.config {
                -- disable virtual text
                virtual_text = true,

                -- show signs
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.error,
                        [vim.diagnostic.severity.WARN] = icons.warn,
                        [vim.diagnostic.severity.HINT] = icons.hint,
                        [vim.diagnostic.severity.INFO] = icons.info,
                    },
                },

                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }
        end
    },
}
