return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope.nvim",
        event = { "VeryLazy" },
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    selection_caret = " ",
                    entry_prefix = " ",
                    prompt_prefix = "    ",
                    initial_mode = "insert",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.3,
                        },

                        vertical = {
                            mirror = false,
                        },

                        -- width and height of telescope
                        width = 0.8,
                        height = 0.7,

                        preview_cutoff = 120,
                    },
                    file_ignore_patterns = { "node_modules" },
                },
                extensions = {
                    file_browser = {
                        theme = "dropdown",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {},
                            ["n"] = {
                                ["l"] = "select_default",
                            },
                        },
                    },
                },
            })

            require("telescope").load_extension "file_browser"
        end
    },
}
