-- See: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "VeryLazy" },
        opts = {
            autopairs = {
                enable = true
            }
        },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
