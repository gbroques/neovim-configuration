return {
  {
    'rebelot/heirline.nvim',
    commit = '2a151df2dc870e79b138a59ebaaaddf3d1b0d703',
    event = 'VeryLazy',
    config = function()
      -- TODO:
      -- Build my own statusline.
      -- https://jip.dev/posts/a-simpler-vim-statusline/
      -- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
      -- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
      -- https://nihilistkitten.me/nvim-lua-statusline/
      -- Ideas of things to include from the above articles:
      -- - mode - possibly shortened to 1 or 3 letters.
      -- - fileformat & encoding if not unix or utf-8
      -- - nvim-dap status - whether there's an active debugging sessios
      --
      local colors = require('tokyonight.colors').setup()

      local conditions = require('heirline.conditions')
      local utils = require('heirline.utils')
      local Align = { provider = '%=' }
      local Space = { provider = ' ' }

      -- Mode colors copied from tokyonight lualine theme:
      -- https://github.com/folke/tokyonight.nvim/blob/v1.17.0/lua/lualine/themes/tokyonight.lua#L6-L41
      local mode_colors = {
        normal = colors.blue,
        insert = colors.green,
        command = colors.yellow,
        visual = colors.magenta,
        replace = colors.red,
        terminal = colors.green,
      }

      -- Base component for other components to inherit mode_color method from.
      local ModeAwareStatusLine = {
        static = {
          -- :h mode()
          color_by_first_mode_character = {
            n = mode_colors.normal,
            i = mode_colors.insert,
            v = mode_colors.visual,
            V = mode_colors.visual,
            -- CTRL-V
            ['\22'] = mode_colors.visual,
            c = mode_colors.command,
            s = mode_colors.visual,
            S = mode_colors.visual,
            -- CTRL-S
            ['\19'] = mode_colors.visual,
            R = mode_colors.replace,
            r = mode_colors.replace,
            ['!'] = mode_colors.terminal,
            t = mode_colors.terminal,
          },
          mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode(1) or 'n'
            return self.color_by_first_mode_character[mode]
          end
        },
        condition = function()
          return not conditions.buffer_matches({ filetype = { 'NvimTree' } })
        end
      }


      local Mode = {
        static = {
          -- Mode names copied from lualine:
          -- https://github.com/nvim-lualine/lualine.nvim/blob/e37d5d325da9c472c73d97bd0210c480c5d9babc/lua/lualine/utils/mode.lua#L6-L43
          mode_names = {
            ['n']     = 'NORMAL',
            ['no']    = 'O-PENDING',
            ['nov']   = 'O-PENDING',
            ['noV']   = 'O-PENDING',
            ['no\22'] = 'O-PENDING',
            ['niI']   = 'NORMAL',
            ['niR']   = 'NORMAL',
            ['niV']   = 'NORMAL',
            ['nt']    = 'NORMAL',
            ['ntT']   = 'NORMAL',
            ['v']     = 'VISUAL',
            ['vs']    = 'VISUAL',
            ['V']     = 'V-LINE',
            ['Vs']    = 'V-LINE',
            ['\22']   = 'V-BLOCK',
            ['\22s']  = 'V-BLOCK',
            ['s']     = 'SELECT',
            ['S']     = 'S-LINE',
            ['\19']   = 'S-BLOCK',
            ['i']     = 'INSERT',
            ['ic']    = 'INSERT',
            ['ix']    = 'INSERT',
            ['R']     = 'REPLACE',
            ['Rc']    = 'REPLACE',
            ['Rx']    = 'REPLACE',
            ['Rv']    = 'V-REPLACE',
            ['Rvc']   = 'V-REPLACE',
            ['Rvx']   = 'V-REPLACE',
            ['c']     = 'COMMAND',
            ['cv']    = 'EX',
            ['ce']    = 'EX',
            ['r']     = 'REPLACE',
            ['rm']    = 'MORE',
            ['r?']    = 'CONFIRM',
            ['!']     = 'SHELL',
            ['t']     = 'TERMINAL',
          },
        },
        provider = function(self)
          return ' ' .. self.mode_names[vim.fn.mode()] .. ' '
        end,
        hl = function(self)
          return { fg = colors.black, bg = self:mode_color() }
        end,
        update = {
          'ModeChanged',
          pattern = '*:*',
          callback = vim.schedule_wrap(function()
            vim.cmd('redrawstatus')
          end),
        },
      }

      --TODO: This is an internal module. Replace with copied functions.
      --it makes more sense for lighten to be 30% instead of the inverse 70%
      local colors_util = require('tokyonight.util')
      local file_modified_lighten_percentage = 0.70

      local function format_uri(uri)
        if vim.startswith(uri, 'jdt://') then
          local package = uri:match('contents/[%a%d._-]+/([%a%d._-]+)') or ''
          local class = uri:match('contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class') or ''
          return string.format('%s::%s', package, class)
        else
          return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
        end
      end

      local function get_filename()
        return format_uri(vim.uri_from_bufnr(vim.api.nvim_get_current_buf()))
      end
      local function contains(tab, val)
        for _, value in ipairs(tab) do
          if value == val then
            return true
          end
        end
      end
      local only_show_mode = function()
        local filetypes_to_only_show_mode = {
          'alpha',
          'lazy',
          'TelescopePrompt'
        }
        return contains(filetypes_to_only_show_mode, vim.bo.filetype)
      end
      local FileName = {
        provider = function()
          if only_show_mode() then return '' end
          if vim.api.nvim_buf_get_name(0) == '' then return '' end
          -- trim the pattern relative to the current directory.
          -- For other options, see :h filename-modifers
          local filename = get_filename()
          -- if the filename occupies more than 1/4th of the available
          -- space, then trim the filepath to its initials
          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          return ' ' .. filename .. ' '
        end,
        hl = function(self)
          local fg = self:mode_color()
          if vim.bo.modified then
            fg = colors_util.lighten(fg, file_modified_lighten_percentage)
          end
          return { fg = fg, bg = colors.fg_gutter }
        end,
      }

      local get_file_flag = function(icon)
        if only_show_mode() then return '' end
        local display_string = icon .. ' '
        if vim.api.nvim_buf_get_name(0) == '' then
          display_string = ' ' .. display_string
        end
        return display_string
      end

      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = function()
            return get_file_flag('●')
          end,
          hl = function(self)
            return { fg = colors_util.lighten(self:mode_color(), file_modified_lighten_percentage) }
          end
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = function()
            return get_file_flag('')
          end,
          hl = { fg = colors.red },
        },
      }

      local FileNameBlock = {
        hl = function(self)
          local fg = self:mode_color()
          if vim.bo.modified then
            fg = colors_util.lighten(fg, file_modified_lighten_percentage)
          end
          return { fg = fg, bg = colors.fg_gutter }
        end,
      }

      -- Add children to FileNameBlock
      FileNameBlock = utils.insert(
        FileNameBlock,
        FileName,
        FileFlags,
        -- Cut statusline here when there's not enough space
        { provider = '%<' }
      )

      local Diagnostics = {
        condition = conditions.has_diagnostics,
        static = {
          error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
          warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
        },
        init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        end,
        update = { 'DiagnosticChanged', 'BufEnter' },
        {
          provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
          end,
          hl = { fg = colors.error, bg = colors.bg_statusline },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
          end,
          hl = { fg = colors.warning, bg = colors.bg_statusline },
        },
      }

      require('lsp-progress').setup({
        -- TODO: Consider simpler spinner
        -- spinner = { ' -', ' \\', ' |', ' /' },
        -- Format client message.
        --
        --- @param client_name string
        ---     Client name.
        --- @param spinner string
        ---     Spinner icon.
        --- @param series_messages string[]|table[]
        ---     Messages array.
        --- @return ClientFormatResult
        ---     The returned value will be passed to function `format` as one of the
        ---     `client_messages` array, or ignored if return nil.
        client_format = function(client_name, spinner, series_messages)
          return #series_messages > 0
              and spinner .. ' ' .. client_name
              or client_name
        end,
        -- Format (final) message.
        --
        --- @param client_messages string[]|table[]
        ---     Client messages array.
        --- @return string
        ---     The returned value will be returned as the result of `progress` API.
        format = function(client_messages)
          if #client_messages > 0 then
            return table.concat(client_messages, " ")
          else
            return table.concat(vim.tbl_map(function(client)
              return client.config.name
            end, vim.lsp.get_active_clients()), " ")
          end
        end,
      })
      local LspSpinner = {
        condition = conditions.lsp_attached,
        provider = require('lsp-progress').progress,
        hl = function(self)
          return { fg = self:mode_color(), bg = colors.bg_statusline }
        end,
        update = {
          'User',
          pattern = 'LspProgressStatusUpdated',
          callback = vim.schedule_wrap(function()
            vim.cmd('redrawstatus')
          end),
        }
      }

      local ColumnNumber = {
        provider = ' %2(%c%) ',
        hl = function(self)
          return { fg = self:mode_color(), bg = colors.fg_gutter }
        end,
      }

      -- Add children to ModeAwareStatusLine
      local StatusLine = utils.insert(
        ModeAwareStatusLine,
        Mode,
        FileNameBlock,
        Space,
        Diagnostics,
        Align,
        LspSpinner,
        Space,
        ColumnNumber
      )
      -- TODO: Add nvim-dap status for debugging.
      -- https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#debugger
      -- TODO: Add indicator of running tests.
      require('heirline').setup({
        statusline = StatusLine
      })
    end
  },
}
