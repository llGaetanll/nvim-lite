return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup {
                indent = {
                    enable = true,
                    style = { vim.api.nvim_get_hl(0, { name = "Base01Fg" }) },
                },
            }
        end,
    },
    {
        "nmac427/guess-indent.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("guess-indent").setup {
                auto_cmd = true,
            }
        end,
    },
}
