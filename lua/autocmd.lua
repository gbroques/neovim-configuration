-- Autocommands
-- :help autocommands
-- TJ DeVries - [Demo] Lua Autocmd Patterns
-- https://www.youtube.com/watch?v=HR1dKKrOmDs
-- :help events
-- TJ DeVries - [Demo] Lua Augroups - Why And How To Use?
-- https://www.youtube.com/watch?v=F6GNPOXpfwU
-- See also:
-- https://itmecho.com/blog/neovim-lua-hooks-with-user-events


-- highlight yanked selection
-- https://neovim.io/doc/user/lua.html#lua-highlight
-- Conflicts with vim-illuminate plugin. See:
-- https://github.com/RRethy/vim-illuminate/issues/107
-- local handle_highlight = function(e)
--   vim.highlight.on_yank({ higroup = 'IncSearch' })
-- end
-- vim.api.nvim_create_autocmd('TextYankPost', { pattern = '*', callback = handle_highlight })
