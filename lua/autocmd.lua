-- Autocommands
-- :help autocommands
-- TJ DeVries - [Demo] Lua Autocmd Patterns
-- https://www.youtube.com/watch?v=HR1dKKrOmDs
-- :help events
-- TJ DeVries - [Demo] Lua Augroups - Why And How To Use?
-- https://www.youtube.com/watch?v=F6GNPOXpfwU
-- See also:
-- https://itmecho.com/blog/neovim-lua-hooks-with-user-events

-- Highlight yanked selection.
-- https://neovim.io/doc/user/lua.html#vim.hl
local handle_highlight = function()
  vim.hl.on_yank({ higroup = 'IncSearch' })
end
vim.api.nvim_create_autocmd('TextYankPost', { pattern = '*', callback = handle_highlight })

-- Open help window in a vertical split to the right.
-- https://vi.stackexchange.com/a/39697
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help_window_right', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd('L') end
  end
})

-- Automatically enter INSERT mode upon opening a terminal.
-- https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane
-- https://github.com/nvim-neotest/neotest/issues/2#issuecomment-1149532666
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  callback = function()
    if vim.startswith(vim.api.nvim_buf_get_name(0), "term://") then
      vim.cmd("startinsert")
    end
  end
})
