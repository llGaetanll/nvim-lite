-- See: https://github.com/nvim-treesitter/nvim-treesitter (main branch)
local languages = { "rust", "lua", "javascript", "typescript", "tsx" }
local filetypes = { "rust", "lua", "javascript", "typescript", "typescriptreact" }

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install(languages)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    }
}
