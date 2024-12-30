local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'Podświetl tekst po skopiowaniu',
  group = augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})
