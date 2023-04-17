vim.cmd("colorscheme darkplus")
-- https://github.com/LunarVim/darkplus.nvim/blob/master/lua/darkplus/theme.lua#L303
local c = require('darkplus.palette')

-- override italic to false
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.info, bg = 'NONE', bold = true, italic = false, })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.folder_blue, bg = 'NONE', bold = true, italic = false, })

