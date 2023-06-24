local telescope = require('telescope')
telescope.setup {
  defaults = {
    wrap_results = true,
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
      results_title = false,
      preview_title = false,
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = 'top',
        preview_cutoff = 1,
        preview_height = 0.70,
        mirror = true
      },
    }
  }
}
telescope.load_extension('ui-select')
telescope.load_extension('fzf')
telescope.load_extension('projects')

