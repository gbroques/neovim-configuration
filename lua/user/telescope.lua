local telescope = require('telescope')
-- local ext = require("telescope._extensions")
-- local frecency_db = require("frecency.db")
--
-- local fzf = ext.manager.fzf
--
-- local function frecency_score(self, prompt, line, entry)
--   if prompt == nil or prompt == "" then
--     for _, file_entry in ipairs(self.state.frecency) do
--       local filepath = entry.cwd .. "/" .. entry.value
--       if file_entry.filename == filepath then
--         return 9999 - file_entry.score
--       end
--     end
--
--     return 9999
--   end
--
--   return self.default_scoring_function(self, prompt, line, entry)
-- end
--
-- local function frecency_start(self, prompt)
--   self.default_start(self, prompt)
--
--   if not self.state.frecency then
--     self.state.frecency = frecency_db.get_files({ with_score = true })
--   end
-- end
--
-- local frecency_sorter = function(opts)
--   local fzf_sorter = fzf.native_fzf_sorter()
--
--   fzf_sorter.default_scoring_function = fzf_sorter.scoring_function
--   fzf_sorter.default_start = fzf_sorter.start
--
--   fzf_sorter.scoring_function = frecency_score
--   fzf_sorter.start = frecency_start
--
--   return fzf_sorter
-- end

telescope.setup {
  defaults = {
    wrap_results = true,
    results_title = false,
    file_ignore_patterns = {
      "^.git/"
    },
    layout_config = {
      -- Fullscreen
      width = { padding = 0 },
      height = { padding = 0 },
    },
    -- file_sorter = frecency_sorter
  },
  pickers = {
    lsp_references = {
      prompt_title = 'References',
      preview_title = false,
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = 'top',
        preview_cutoff = 1,
        preview_height = 0.60,
        mirror = true
      },
    },
    find_files = {
      preview_title = false
    },
    live_grep = {
      preview_title = false,
      prompt_title = 'Search'
    }
  },
  extensions = {
    frecency = {
      show_filter_column = { 'LSP' },
      workspaces = {
        -- root duplicated in ftplugin/java.lua
        root = require('jdtls.setup').find_root({ 'pom.xml', '.git' })
      }
    }
  }
}
telescope.load_extension('ui-select')
-- telescope.load_extension('fzf')
telescope.load_extension('projects')

-- TODO: Use join_path in ftplugin/java.lua
vim.g.sqlite_clib_path = vim.fn.stdpath('data') .. '\\sqlite3.dll'
telescope.load_extension('frecency')
