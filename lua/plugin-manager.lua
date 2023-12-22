local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader Key
-- ----------------------------------------------------
-- Set `mapleader` before lazy so mappings are correct.
-- Article on why space for the leader key:
-- https://raindev.io/blog/space-leader/
vim.g.mapleader = ' '
-------------------------------------------------------

require('lazy').setup('plugins', {
  git = { timeout = 600 },
  ui = {
    -- Fullscreen
    size = { height = vim.o.lines - 1, width = vim.o.columns }
  },
  change_detection = { notify = false }
})
