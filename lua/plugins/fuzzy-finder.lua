return {
  {
    'nvim-telescope/telescope.nvim',
    commit = '2ea8dcd17b4f9b7714354965a28ae4fef4139c71',
    event = { 'LspAttach' }, -- telescope used as vim.ui.select for code actions
    cmd = { 'Telescope' },
    keys = {

      -- TODO Sort files by recently opened.
      -- https://github.com/nvim-telescope/telescope.nvim/issues/2109
      -- smartpde/telescope-recent-files
      -- The following all require sqlite:
      -- danielfalk/smart-open.nvim
      -- prochri/telescope-all-recent.nvim
      -- telescope-frecency no longer requires sqlite, we should try it again:
      -- nvim-telescope/telescope-frecency.nvim
      { '<leader>f', function()
        -- find_root duplicated in ftplugin/java.lua
        local cwd = require('jdtls.setup').find_root({ 'pom.xml', '.git' })
        require('telescope.builtin').find_files({ cwd = cwd })
      end, { desc = 'Find files' } },
      { '<leader>sb', ':Telescope buffers<CR>',      desc = 'Buffers' },
      { '<leader>sc', ':Telescope commands<CR>',     desc = 'Commands' },
      { '<leader>sd', ':Telescope diagnostics<CR>',  desc = 'Diagnostics' },
      { '<leader>ss', ':Telescope live_grep<CR>',    desc = 'Search' },
      { '<leader>S',  '<leader>ss',                  desc = 'Search',            remap = true },
      { '<leader>sh', ':Telescope help_tags<CR>',    desc = 'Help' },
      { '<leader>sj', ':Telescope jumplist<CR>',     desc = 'Jumplist' },
      { '<leader>sk', ':Telescope keymaps<CR>',      desc = 'Keymaps' },
      { '<leader>sm', ':Telescope marks<CR>',        desc = 'Marks' },
      -- TODO: Change to <leader> p if projects shortcut is common
      { '<leader>sp', ':Telescope projects<CR>',     desc = 'Projects' },
      { '<leader>sq', ':Telescope quickfix<CR>',     desc = 'Quickfix' },
      { '<leader>sr', ':Telescope registers<CR>',    desc = 'Registers' },
      -- Git
      { '<leader>gb', ':Telescope git_branches<CR>', desc = 'Branches' },
      { '<leader>gc', ':Telescope git_commits<CR>',  desc = 'Commits' },
      { '<leader>gC', ':Telescope git_bcommits<CR>', desc = 'Commits for buffer' },
      { '<leader>gs', ':Telescope git_status<CR>',   desc = 'Status' },
      -- LSP
      -- TODO: Write function that goes to reference automatically if there's only 1,
      -- and open Telescope if there's more than 1 reference.
      -- https://matrix.to/#/!cxlVvaAjYkBpQTKumW:gitter.im/$XuhOCs-CBTyGDT5cSSrwFvDUVlxbtlSISmztUEbG1Bo?via=matrix.org&via=gitter.im
      -- This appears to be a bug, with a neglected / stale PR to fix it:
      -- https://github.com/nvim-telescope/telescope.nvim/pull/2281
      { 'gr', function()
        -- Consider LSP Saga for references instead:
        -- https://nvimdev.github.io/lspsaga/finder/
        require('telescope.builtin').lsp_references({ include_declaration = false })
      end, { desc = 'Goto references' } },
      { 'gW', ':Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workplace symbols' },
    },
    dependencies = {
      {
        'nvim-lua/plenary.nvim'
      },
      -- for nvim-jdtls
      -- https://github.com/mfussenegger/nvim-jdtls/wiki/UI-Extensions
      {
        'nvim-telescope/telescope-ui-select.nvim',
        commit = '62ea5e58c7bbe191297b983a9e7e89420f581369'
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        commit = '9bc8237565ded606e6c366a71c64c0af25cd7a50'
      },
    },
    config = function()
      local telescope = require('telescope')
      local sorters = require('telescope.sorters')
      local fzy_sorter = sorters.get_fzy_sorter()
      local filter = vim.tbl_filter

      -- Copied from:
      -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/builtin/__internal.lua#L17-L29
      local function apply_cwd_only_aliases(opts)
        local has_cwd_only = opts.cwd_only ~= nil
        local has_only_cwd = opts.only_cwd ~= nil

        if has_only_cwd and not has_cwd_only then
          -- Internally, use cwd_only
          opts.cwd_only = opts.only_cwd
          opts.only_cwd = nil
        end

        return opts
      end
      -- Copied from:
      -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/builtin/__internal.lua#L872-L923
      local get_buffers = function(opts)
        opts = opts or {}
        opts = apply_cwd_only_aliases(opts)
        local bufnrs = filter(function(b)
          if 1 ~= vim.fn.buflisted(b) then
            return false
          end
          -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
          if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
            return false
          end
          if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
            return false
          end
          if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
            return false
          end
          if not opts.cwd_only and opts.cwd and not string.find(vim.api.nvim_buf_get_name(b), opts.cwd, 1, true) then
            return false
          end
          return true
        end, vim.api.nvim_list_bufs())
        if not next(bufnrs) then
          return
        end
        if opts.sort_mru then
          table.sort(bufnrs, function(a, b)
            return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
          end)
        end

        local buffers = {}
        for _, bufnr in ipairs(bufnrs) do
          local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

          local element = {
            bufnr = bufnr,
            flag = flag,
            info = vim.fn.getbufinfo(bufnr)[1],
          }

          if opts.sort_lastused and (flag == "#" or flag == "%") then
            local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
            table.insert(buffers, idx, element)
          else
            table.insert(buffers, element)
          end
        end
        return buffers
      end

      local is_file_open = function(line)
        local buffers = get_buffers()
        if not buffers then
          return false
        end
        -- TODO: This may not be performant if there are many open buffers.
        -- We could implement a map / lookup table instead.
        for _, buffer in ipairs(buffers) do
          local buffer_name = buffer.info.name
          if vim.endswith(buffer_name, line) then
            return true
          end
        end
        return false
      end

      -- Copied from:
      -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/sorters.lua#L437-L466
      -- Sorter using the fzy algorithm
      local file_sorter = function(opts)
        opts = opts or {}
        local fzy = opts.fzy_mod or require "telescope.algos.fzy"
        local OFFSET = -fzy.get_score_floor()

        return sorters.Sorter:new {
          discard = fzy_sorter.discard,

          scoring_function = function(_, prompt, line)
            -- Check for actual matches before running the scoring alogrithm.
            if not fzy.has_match(prompt, line) then
              return -1
            end

            local fzy_score = fzy.score(prompt, line)

            -- The fzy score is -inf for empty queries and overlong strings.  Since
            -- this function converts all scores into the range (0, 1), we can
            -- convert these to 1 as a suitable "worst score" value.
            if fzy_score == fzy.get_score_min() then
              return 1
            end

            -- Double score if file is open.
            -- TODO: Score boost could take into account sort order of buffers.
            -- Like which one was last used.
            if is_file_open(line) then
              fzy_score = fzy_score * 2
            end

            -- Poor non-empty matches can also have negative values. Offset the score
            -- so that all values are positive, then invert to match the
            -- telescope.Sorter "smaller is better" convention. Note that for exact
            -- matches, fzy returns +inf, which when inverted becomes 0.
            return 1 / (fzy_score + OFFSET)
          end,

          highlighter = fzy_sorter.highlighter
        }
      end
      telescope.setup {
        defaults = {
          file_sorter = file_sorter,
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
        }
      }
      telescope.load_extension('ui-select')
      telescope.load_extension('projects')
    end
  },
}
