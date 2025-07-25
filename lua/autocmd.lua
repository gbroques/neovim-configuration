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

-- Automatically make the help window the only one on the screen.
-- https://vi.stackexchange.com/a/39697
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('maximize_help', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd('o') end
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
-- Automatically close terminal buffer when process exits successfully (Ctrl + d),
-- or when using the exit command in fish.
-- https://fishshell.com/docs/current/cmds/exit.html
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    local status = vim.v.event.status
    if status == 0 or status == 255 then
      vim.cmd("bdelete! " .. vim.fn.expand("<abuf>"))
    end
  end
})
