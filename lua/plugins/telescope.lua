local function telescope_refresh(bufnr)
    local actions = require "telescope.actions"

    actions.refresh(bufnr)
end

local function telescope_vsplit(bufnr)
    local actions = require "telescope.actions"

    actions.select_vertical(bufnr)
end

local function telescope_hsplit(bufnr)
    local actions = require "telescope.actions"

    actions.select_horizontal(bufnr)
end

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
            local fb_actions = require "telescope".extensions.file_browser.actions

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
                    mappings = {
                        n = {
                            ["R"] = telescope_refresh,
                            ["i"] = telescope_vsplit,
                            ["o"] = telescope_hsplit,
                        },
                        i = {}
                    },
                },
                extensions = {
                    file_browser = {
                        theme = "dropdown",
                        hijack_netrw = true,
                        hide_parent_dir = true,
                        grouped = true,
                        sorting_strategy = "ascending",
                        initial_mode = "normal",
                        mappings = {
                            ["i"] = {},
                            ["n"] = {
                                ["l"] = "select_default",
                                ["h"] = fb_actions.goto_parent_dir,
                                ["H"] = fb_actions.toggle_hidden,
                                ["I"] = fb_actions.toggle_respect_gitignore,

                                ["d"] = fb_actions.remove,
                                ["y"] = fb_actions.copy,
                                ["r"] = fb_actions.rename,
                                ["a"] = fb_actions.create,
                            },
                        },
                    },
                },
            })

            require("telescope").load_extension "file_browser"
        end
    },
}
