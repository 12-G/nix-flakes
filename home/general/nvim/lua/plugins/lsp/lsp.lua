local neodev = require("neodev")
local lspconfig = require("lspconfig")
local utils = require "core.utils"

local servers = {
  "pyright",
  "bashls",
  "nixd",
}

local on_attach = function(_, bufnr)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
  utils.load_mappings("lspconfig", { buffer = bufnr })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

neodev.setup({
  library = {
    plugins = { "nvim-dap-ui" },
    types = true,
  },
})

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
    },
  },
}

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--background-index',
  },
})

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
