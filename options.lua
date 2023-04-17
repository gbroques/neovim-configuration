
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.smartindent = true        -- make indenting smarter again
vim.opt.showmode = false          -- we don't need to see things like -- INSERT -- anymore
vim.opt.mouse = 'a'               -- allow mouse in neovim

-- Set hybrid relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight cursor line.
vim.opt.cursorline = true

-- for bufferline
vim.opt.termguicolors = true
