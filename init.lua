require "config.options"

require "config.lazy"

local keybinds = require "config.keybinds"

-- set keymaps
for _, km in ipairs(keybinds.system) do
    vim.keymap.set(km.mode, km.keymap, km.action, { noremap = true, silent = true, desc = km.desc })
end
