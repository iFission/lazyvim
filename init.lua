-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
lspconfig.tsserver.setup({
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
})

vim.opt.diffopt:append({
  "internal",
  "filler",
  "vertical",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
  "context:10",
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    vim.opt_local.diffopt:append("linematch:80")
  end,
})

vim.cmd("source ~/.vimrc")
