local telescope = require('telescope')
telescope.setup {
  defaults = {
    wrap_results = true,
    file_ignore_patterns = {
      ".git"
    },
    layout_config = {
      width = 0.95,
    },
  }
}
telescope.load_extension("ui-select")
telescope.load_extension("fzf")

