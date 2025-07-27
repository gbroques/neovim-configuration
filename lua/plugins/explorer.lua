return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '1c733e8c1957dc67f47580fe9c458a13b5612d5b',
    -- The consequence of lazy-loading on NvimTreeToggle
    -- is that we use netrw if you open a directory with nvim.
    cmd = 'NvimTreeToggle',
    config = function()
      local icons = require('icons')

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

          -- TODO: Use https://github.com/antosha417/nvim-lsp-file-operations to update code when renaming via nvim-tree?

          -- Group empty directories for Java development
          group_empty = true,
          -- TODO: Should these come from icons module?
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
          icons = icons.diagnostics
        },
      }
    end
  }
}
