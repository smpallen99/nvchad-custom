-- local autocmd = vim.api.nvim_create_autocmd
--
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto"
vim.opt.wrap = false

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_scroll_animation_length = 0.5

vim.g.autoformat_enabled = true -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
vim.g.cmp_enabled = true -- enable completion at start
vim.g.autopairs_enabled = true -- enable autopairs at start
vim.g.diagnostics_mode = 3 -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
vim.g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
vim.g.ui_notifications_enabled = true -- disable notifications when toggling UI elements

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

-- require("ex_projectionist").setup()

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
