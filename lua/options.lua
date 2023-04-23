-- :help options
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.expandtab = true          -- convert tabs to spaces in Insert mode
vim.opt.shiftwidth = 0            -- number of spaces for each step of (auto)indent
vim.opt.tabstop = 2               -- Number of spaces that a <Tab> in the file countsr for.
vim.opt.smartindent = true        -- make indenting smarter again
vim.opt.showmode = false          -- we don't need to see things like -- INSERT -- anymore
vim.opt.mouse = 'a'               -- allow mouse in neovim
vim.opt.number = true             -- Show line numbers.
vim.opt.relativenumber = true     -- Show line number relative to cursor line.
vim.opt.cursorline = true         -- Highlight text line of cursor.
vim.opt.termguicolors = true      -- Enable 24-bit RGB color in TUI.
vim.opt.ignorecase = true         -- ignore case when searching.
vim.opt.smartcase = true          -- perform case-sensitive search upon uppercase.
-- https://www.reddit.com/r/neovim/comments/xjakdy/neovim_gitsigndiagnostic_icons_causes_layout_shift/
vim.opt.signcolumn = 'yes'        -- always show sign column to avoid layout shift.
vim.opt.ruler = false             -- Don't show the line and column number of the cursor position
