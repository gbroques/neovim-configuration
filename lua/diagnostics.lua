vim.diagnostic.config({
  virtual_text = false
})
-- TODO: Create icons file like LunarVim?
-- https://github.com/LunarVim/LunarVim/blob/1.2.0/lua/lvim/icons.lua#L131-L144
-- warning & error duplicated in statusline
local icons = {
  hint = "",
  info = "",
  warning = "",
  error = "",
}
local function lspSymbol(name, icon)
  local highlight = 'DiagnosticSign' .. name
  vim.fn.sign_define(
    highlight,
    { text = icon, texthl = highlight }
  )
end
lspSymbol('Error', icons.error)
lspSymbol('Hint', icons.hint)
lspSymbol('Info', icons.info)
lspSymbol('Warn', icons.warning)
