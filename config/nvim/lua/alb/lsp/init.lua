local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("alb.lsp.lsp-installer")
require("alb.lsp.handlers").setup()
require("alb.lsp.null-ls")
