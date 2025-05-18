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
            -- clear FileExplorer appropriately to prevent netrw from launching on folders
            -- netrw may or may not be loaded before telescope-find-files
            -- conceptual credits to nvim-tree and telescope-file-browser
            local find_files_hijack_netrw = vim.api.nvim_create_augroup("find_files_hijack_netrw", { clear = true })
            vim.api.nvim_create_autocmd("VimEnter", {
                pattern = "*",
                once = true,
                callback = function()
                    pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
                end,
            })

            vim.api.nvim_create_autocmd("BufEnter", {
                group = find_files_hijack_netrw,
                pattern = "*",
                callback = function()
                    vim.schedule(function()
                        -- Early return if netrw or not a directory
                        if vim.bo[0].filetype == "netrw" or vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 then
                            return
                        end

                        vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

                        require("telescope.builtin").find_files({
                            cwd = vim.fn.expand("%:p:h"),
                        })
                    end)
                end,
            })

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
                            ["<c-i>"] = telescope_vsplit,
                            ["<c-o>"] = telescope_hsplit,
                        },
                        i = {}
                    },
                },
                pickers = {
                    find_files = { theme = "dropdown" },
                    live_grep = { theme = "ivy" }
                },
                extensions = {
                    file_browser = {
                        theme = "dropdown",
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
