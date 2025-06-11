local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
