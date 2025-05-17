local function diffview_toggle(cmd)
    local diffview_open = false

    -- Iterate through all tabs
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        -- Get windows in this tab
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)

            if buf_name:match("^diffview") then
                diffview_open = true
                break
            end
        end
        if diffview_open then break end
    end

    if diffview_open then
        vim.cmd [[DiffviewClose]]
    else
        vim.cmd(cmd)
    end
end

local function diffview_toggle_open()
    diffview_toggle [[DiffviewOpen]]
end

local function diffview_toggle_file_history()
    diffview_toggle [[DiffviewFileHistory]]
end

local function telescope_file_browser(opts)
    require("telescope").extensions.file_browser.file_browser(opts)
end

local function telescope_find_files(opts)
    require("telescope.builtin").find_files(opts)
end

local function telescope_live_grep(opts)
    require("telescope.builtin").live_grep(opts)
end

local function telescope_help_tags(opts)
    require("telescope.builtin").help_tags(opts)
end

local function telescope_highlights(opts)
    require("telescope.builtin").highlights(opts)
end

local function telescope_keymaps(opts)
    require("telescope.builtin").keymaps(opts)
end

local keymaps = {
    -- Disable mouse right click
    { mode = { "n", "i", "v" }, keymap = "<RightMouse>",    action = "<nop>" },

    -- WhichKey
    { mode = "n",               keymap = "<leader><Space>", action = "<cmd>WhichKey<CR>",                 desc = "List all keybinds", },

    -- Resize panes
    { mode = "n",               keymap = "<C-Up>",          action = "<cmd>resize -2<CR>",                desc = "Resize windows", },
    { mode = "n",               keymap = "<C-Down>",        action = "<cmd>resize +2<CR>",                desc = "Resize windows", },
    { mode = "n",               keymap = "<C-Left>",        action = "<cmd>vertical resize -2<CR>",       desc = "Resize windows", },
    { mode = "n",               keymap = "<C-Right>",       action = "<cmd>vertical resize +2<CR>",       desc = "Resize windows", },

    -- Navigate Panes
    { mode = "n",               keymap = "<c-k>",           action = "<C-w>k",                            desc = "Navigate to window above", },
    { mode = "n",               keymap = "<c-j>",           action = "<C-w>j",                            desc = "Navigate to window below", },
    { mode = "n",               keymap = "<c-h>",           action = "<C-w>h",                            desc = "Navigate to left window", },
    { mode = "n",               keymap = "<c-l>",           action = "<C-w>l",                            desc = "Navigate to right window", },

    -- Move Panes
    { mode = "n",               keymap = "<Up>",            action = "<C-w>K",                            desc = "Move window above", },
    { mode = "n",               keymap = "<Down>",          action = "<C-w>J",                            desc = "Move window below", },
    { mode = "n",               keymap = "<Left>",          action = "<C-w>H",                            desc = "Move window left", },
    { mode = "n",               keymap = "<Right>",         action = "<C-w>L",                            desc = "Move window right", },

    -- Clear search highlighting
    { mode = "n",               keymap = "<Esc>",           action = ":noh<CR>",                          desc = "clear search highlight", },

    -- Stay in visual mode after indenting
    { mode = "v",               keymap = "<",               action = "<gv",                               desc = "indent less", },
    { mode = "v",               keymap = ">",               action = ">gv",                               desc = "indent more", },

    -- Copy to system clipboard in visual/visual block mode
    { mode = "v",               keymap = "<c-y>",           action = '"+y',                               desc = "copy to system clipboard", },
    { mode = "x",               keymap = "<c-y>",           action = '"+y',                               desc = "copy to system clipboard", },

    -- Diffview
    { mode = "n",               keymap = "<leader>dd",      action = diffview_toggle_open,                desc = "Diffview Toggle", },
    { mode = "n",               keymap = "<leader>dr",      action = "<cmd>DiffviewRefresh<CR>",          desc = "[D]iffview [R]efresh", },
    { mode = "n",               keymap = "<leader>dh",      action = diffview_toggle_file_history,        desc = "[D]iffview File [H]istory", },

    -- Gitsigns
    { mode = "n",               keymap = "[g",              action = "<cmd>Gitsigns next_hunk<CR>",       desc = "Next Hunk", },
    { mode = "n",               keymap = "]g",              action = "<cmd>Gitsigns prev_hunk<CR>",       desc = "Previous Hunk", },
    { mode = "n",               keymap = "<leader>gs",      action = "<cmd>Gitsigns stage_hunk<CR>",      desc = "[g]it [s]tage hunk", },
    { mode = "n",               keymap = "<leader>gr",      action = "<cmd>Gitsigns reset_hunk<CR>",      desc = "[g]it [r]eset hunk", },
    { mode = "n",               keymap = "<leader>gS",      action = "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "[g]it undo [S]tage hunk", },

    -- Telescope
    { mode = "n",               keymap = "<leader>t",       action = telescope_file_browser,              desc = "Telescope File Browser", },
    { mode = "n",               keymap = "<leader>f",       action = telescope_find_files,                desc = "Telescope [f]ile Search", },
    { mode = "n",               keymap = "<leader>g",       action = telescope_live_grep,                 desc = "Telescope [g]rep Search", },
    { mode = "n",               keymap = "<leader>ut",      action = telescope_help_tags,                 desc = "Telescope [u]itl help [t]ags", },
    { mode = "n",               keymap = "<leader>uh",      action = telescope_highlights,                desc = "Telescope [u]til [h]ighlights", },
    { mode = "n",               keymap = "<leader>uk",      action = telescope_keymaps,                   desc = "Telescope [u]til [k]eybinds", },
}

-- set keymaps
for _, km in ipairs(keymaps) do
    vim.keymap.set(km.mode, km.keymap, km.action, { noremap = true, silent = true, desc = km.desc })
end
