-- :help options
-- vim.opt.clipboard = 'unnamedplus' slows down startup time because Neovim has to locate the system clipboard.
-- See the following Reddit thread:
-- https://www.reddit.com/r/neovim/comments/17ieyn2/comment/k6tpk8a/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

-- Returns TRUE if `cmd` exits with success, else FALSE.
local function cmd_ok(cmd)
  vim.fn.system(cmd)
  return vim.v.shell_error == 0
end

-- Linux
if vim.fn.empty(os.getenv('DISPLAY')) and vim.fn.executable('sel') and cmd_ok('xsel -o -b') then
  -- For xsel configuration, see:
  -- https://github.com/neovim/neovim/blob/v0.11.3/runtime/autoload/provider/clipboard.vim#L95-L101
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
-- Mac
elseif vim.fn.executable('pbcopy') and vim.fn.executable('pbpaste') then
  -- For pbcopy configuration, see:
  -- https://github.com/neovim/neovim/blob/v0.11.3/runtime/autoload/provider/clipboard.vim#L70-L77
  vim.g.clipboard = {
    name = 'pbcopy',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = '+'
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = '+'
    },
    cache_enabled = 1
  }
-- Windows
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
vim.opt.splitbelow = true         -- Put new buffer on the bottom for horizontal splits
vim.opt.fillchars:append { diff = " " }
vim.opt.guifont = 'JetBrainsMono NF'
if vim.fn.has('macunix') == 0 then
  vim.opt.shell = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
end
-- Keep cursor vertically centered (especially after go to definition jumps)
-- https://www.reddit.com/r/neovim/comments/1jqfpyy/comment/ml7q56l/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.opt.scrolloff = 999
