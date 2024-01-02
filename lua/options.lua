-- :help options
-- vim.opt.clipboard = 'unnamedplus' slows down startup time because Neovim has to locate the system clipboard.
-- See the following Reddit thread:
-- https://www.reddit.com/r/neovim/comments/17ieyn2/comment/k6tpk8a/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- For xsel options, see:
-- https://github.com/neovim/neovim/blob/v0.9.4/runtime/autoload/provider/clipboard.vim#L107-L112
-- Returns TRUE if `cmd` exits with success, else FALSE.
local function cmd_ok(cmd)
  -- https://stackoverflow.com/questions/26142177/disable-cmd-output-in-lua
  return os.execute(cmd .. ' &> /dev/null') == 0
end
if vim.fn.empty(os.getenv('DISPLAY')) and vim.fn.executable('sel') and cmd_ok('xsel -o -b') then
  vim.g.clipboard = {
    name = 'xsel',
    copy = {
      ['+'] = 'xsel --nodetach -i -b',
      ['*'] = 'xsel --nodetach -i -p',
    },
    paste = {
      ['+'] = 'xsel -o -b',
      ['*'] = 'xsel -o -p',
    },
    cache_enabled = 1
  }
elseif vim.fn.executable('win32yank') then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 1
  }
end
vim.opt.clipboard = 'unnamedplus' -- allow Neovim to access system clipboard
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
vim.opt.laststatus = 3            -- Enable 'global' statusline; https://www.youtube.com/watch?v=jH5PNvJIa6o
vim.opt.splitright = true         -- Put new buffer on the right for vertical splits
vim.opt.fillchars:append { diff = " " }
vim.opt.guifont = 'JetBrainsMono Nerd Font Mono'
