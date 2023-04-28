-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  -- suggested from ahmedkhalf/project.nvim
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    -- TODO: Enable vinegar style opening?
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#vinegar-style
    -- http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/

    -- Group empty directories for Java development
    group_empty = true,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    -- TODO: Create icons file like LunarVim?
    -- https://github.com/LunarVim/LunarVim/blob/1.2.0/lua/lvim/icons.lua#L131-L144
    -- warning & error duplicated in statusline
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}
