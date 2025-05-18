# `nvim-lite`
A neovim config that strives to be as simple as possible, while remaining usable

## Anti Goals
- Tabs
- Splits

Years of using these features have caused me repeated frustrations, such as:
- Having to think about where a tab/window is, or if it's even open
- Wanting to reorganize my buffer layout, moving splits to other tabs, or tabs
to other splits, etc...

`nvim-lite` is an experiment to try to take all this friction out, and still
make the best possible editor experience. I only have two eyes, I don't need
more than one buffer at a time.

## Goals
- Speed (of editor and of use)
- Out of your way (if it's on the screen, it better be *really* important)

## So how do I use this?

If you're used to the vscode-like neovim interfaces, this might seem like a big
change. This config does everything it can to encourage you to spend less time
on things that don't matter, like cycling through tabs or going down a file
tree. It also tries very hard to make all the most important stuff as accessible
as possible.

1. Use the [jumplist](https://neovim.io/doc/user/motion.html#_8.-jumps).
2. Use [telescope](https://github.com/nvim-telescope/telescope.nvim). This
   configuration comes with handy [key binds](#key_bindings) for live grep, find
   files, and file browser.

## Key Bindings

*This configuration is still in its early stages, expect changes.*

In general, you can find the system keybinds in the
[keybinds](./lua/config/keybinds.lua) file, the
[lsp](./lua/plugins/nvim-lspconfig.lua), and some more in the
[telescope](./lua/plugins/telescope.lua) file. A summary of important bindings
is provided below.

In all of these, space is the leader key.

### Movement

- `ctrl` + `o`: Go back a jump
- `ctrl` + `i`: Go forward a jump
- `<leader>t`: Opens [Telescope file browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)
  Inside of the file browser:
  - `k/j`: goes up/down
  - `l`: opens the file/directory
  - `h`: goes back a directory
  - `a`: creates a file in the current directory
- `<leader>f`: Opens the default [Telescope](https://github.com/nvim-telescope/telescope.nvim) file searcher
- `<leader>l`: Opens the default Telescope live grepper.

### Git

This configuration comes with
[`Diffview`](https://github.com/sindrets/diffview.nvim/) and
[`Gitsigns`](https://github.com/lewis6991/gitsigns.nvim).

- `<leader>dd`: Toggle `Diffview`
- `<leader>dh`: Toggle `Diffview` File History
- `<leader>gs`: Stage hunk
- `<leader>gr`: Reset hunk
- `<leader>gS`: Unstage hunk

## Theming

Theming is powered by [`llGaetanll/base16`](https://github.com/llGaetanll/base16.nvim), which exposes the `:Theme` command.

## TODO
- [x] A basic user guide would be nice
- [x] `nvim-autopairs` doesn't work, parentheses, and quotes are not auto completed
- [x] Keybinds to move between windows actually move the windows themselves
- [x] lsp loads all configs upfront, instead of just the ones loaded into the buffer
- [x] `Gitsigns` toggle hunk in keybinds doesn't actually toggle hunks
- [x] Add lsp-specific config file support
- [x] Only enable mouse for left click
- [x] Configure file management keybinds in Telescope file browser 
- [x] Document theming. Base16 is still young, but quite powerful already.
- [x] Telescope file finder opens the file in Diffview if it's open over it
- [ ] Put **all** keybinds in keybinds file, and export them to the right places
- [ ] Add commit/pull/push support from inside nvim?
- [ ] Format typescript files
- [x] Indents don't adapt to the theme's colors
- [ ] Indent can be guessed wrong if a new file is created and code is pasted
      into it. Somewhere, this config defaults to 8 spaces somehow, and if
      `GuessIndent` is not updated with the new file contents (which might be perfect
      4 spaces code) it will fall back to 8 spaces.

