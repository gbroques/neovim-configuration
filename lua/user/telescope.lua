local telescope = require('telescope')
telescope.setup {
  defaults = {
    wrap_results = true,
    file_ignore_patterns = {
      "^.git/"
    },
    layout_config = {
      width = 0.99,
      height = 0.99
    },
  }
}
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("projects")

