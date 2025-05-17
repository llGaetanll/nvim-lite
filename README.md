# `nvim-plain`
A neovim config that strives to be as simple as possible, while remaining usable

## Anti Goals
- Tabs
- Splits

Years of using these features have caused me repeated frustrations, such as:
- Having to think about where a tab/window is, or if it's even open
- Wanting to reorganize my buffer layout, moving splits to other tabs, or tabs
to other splits, etc.. 

`nvim-plain` is an experiment to try to take all this friction out, and still
make the best possible editor experience. I only have two eyes, I don't need
more than one buffer at a time.

## Goals
- Speed (of editor and of use)
- Out of your way (if it's on the screen, it better be *really* important)

## TODO
- [ ] A basic user guide would be nice
- [x] nvim-autopairs doesn't work, parentheses and quotes are not autocompleted
- [x] keybinds to move between windows actually move the windows themselves
- [ ] lsp loads all configs upfront, instead of just the ones loaded into the buffer
- [x] `Gitsigns` toggle hunk in keybinds doesn't actually toggle hunks
- [x] Add lsp-specific config file support
- [x] Only enable mouse for left click
- [x] Configure file management keybinds in Telescope file browser 
- [ ] Put **all** keybinds in keybinds file, and export them to the right places
