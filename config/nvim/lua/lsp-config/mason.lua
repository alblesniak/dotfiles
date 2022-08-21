require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "angularls",
        "bashls",
        "cssls",
        "dockerls",
        "emmet_ls",
        "html",
        "jsonls",
        "sumneko_lua",
        "marksman",
        "pyright",
        "sqlls",
        "taplo",
        "tailwindcss",
        "tsserver",
        "lemminx",
        "yamlls"
    }
})
