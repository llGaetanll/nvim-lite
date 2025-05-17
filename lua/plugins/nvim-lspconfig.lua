local function custom_goto_prev(severity)
    return function()
        vim.diagnostic.goto_prev { severity = severity }
    end
end

local function custom_goto_next(severity)
    return function()
        vim.diagnostic.goto_next { severity = severity }
    end
end

local prev_error = custom_goto_prev(vim.diagnostic.severity.ERROR)
local next_error = custom_goto_next(vim.diagnostic.severity.ERROR)

local prev_warn = custom_goto_prev(vim.diagnostic.severity.WARN)
local next_warn = custom_goto_next(vim.diagnostic.severity.WARN)

local prev_info = custom_goto_prev(vim.diagnostic.severity.INFO)
local next_info = custom_goto_next(vim.diagnostic.severity.INFO)

local next_hint = custom_goto_prev(vim.diagnostic.severity.HINT)
local prev_hint = custom_goto_next(vim.diagnostic.severity.HINT)

local lsp_implementations = function()
    require("telescope.builtin").lsp_implementations()
end

local lsp_references = function()
    require("telescope.builtin").lsp_references({ trim_text = true })
end

local hover = function()
    -- Extends `vim.lsp.util.open_floating_preview.Opts`
    vim.lsp.buf.hover {
        max_width = 50,
    }
end

local lsp_keymaps = {
    { mode = "n", keymap = "gd",         action = vim.lsp.buf.definition,    desc = "[g]oto [d]efinition", },
    { mode = "n", keymap = "K",          action = hover,                     desc = "Get object Info", },
    { mode = "n", keymap = "gi",         action = lsp_implementations,       desc = "[g]et [i]mplementation", },
    { mode = "n", keymap = "<leader>rn", action = vim.lsp.buf.rename,        desc = "[r]e[n]ame" },
    { mode = "n", keymap = "gr",         action = lsp_references,            desc = "[g]et [r]eferences", },
    { mode = "n", keymap = "<leader>ca", action = vim.lsp.buf.code_action,   desc = "[c]ode [a]ctions", },
    { mode = "n", keymap = "<leader>e",  action = vim.diagnostic.open_float, desc = "Display info about errors", },

    { mode = "n", keymap = "[d",         action = vim.diagnostic.goto_prev,  desc = "Prev Def" },
    { mode = "n", keymap = "]d",         action = vim.diagnostic.goto_next,  desc = "Next Def" },

    { mode = "n", keymap = "[e",         action = prev_error,                desc = "Prev Error" },
    { mode = "n", keymap = "]e",         action = next_error,                desc = "Next Error" },

    { mode = "n", keymap = "[w",         action = prev_warn,                 desc = "Prev Warning", },
    { mode = "n", keymap = "]w",         action = next_warn,                 desc = "Next Warning", },

    { mode = "n", keymap = "[i",         action = prev_info,                 desc = "Prev Info" },
    { mode = "n", keymap = "]i",         action = next_info,                 desc = "Next Info" },

    { mode = "n", keymap = "[h",         action = prev_hint,                 desc = "Prev Hint" },
    { mode = "n", keymap = "]h",         action = next_hint,                 desc = "Next Hint" },
}

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
        for _, km in ipairs(lsp_keymaps) do
            vim.keymap.set(
                km.mode,
                km.keymap,
                km.action,
                { buffer = event.buf, noremap = true, silent = true, desc = "[LSP]: " .. km.desc }
            )
        end

        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format {
                    filter = function(c) return c.name ~= "ts_ls" end
                }
            end,
        })
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
