local telescope = require('telescope')
telescope.setup {
  defaults = {
    wrap_results = true,
    results_title = false,
    file_ignore_patterns = {
      "^.git/"
    },
    layout_config = {
      width = { padding = 0 },
      height = { padding = 0 },
    },
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
      prompt_title = 'Grep'
    }
  }
}
telescope.load_extension('ui-select')
telescope.load_extension('fzf')
telescope.load_extension('projects')

