-- local autocmd = vim.api.nvim_create_autocmd
--

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

require "custom.options"

-- autocmd("BufEnter", {
--   pattern = "*",
--   command = :lua require('lazygit.utils').project_root_dir(),
-- })
-- BufEnter * :lua require('lazygit.utils').project_root_dir()autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
