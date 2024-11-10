local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- require('java').setup()

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- init_options = {
  --   preferences = {
  --     disableSuggestions = true,
  --   }
  -- }
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"json"}
})

lspconfig.solang.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"solidity"},
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

-- lspconfig.jdtls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"java"}
-- })

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"go"}
})

lspconfig.lwc_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
});
