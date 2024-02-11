local options = {
  opt = {
    relativenumber = true,
    signcolumn = "auto",
    wrap = false,
    preserveindent = true, -- preserve indent structure as much as possible
    pumheight = 10, -- height of the pop up menu
    shiftwidth = 2, -- number of space inserted for indentation
    showmode = false, -- disable showing modes in command line
    -- showtabline = 2, -- always display tabline
    smartcase = true, -- case sensitive searching
    splitbelow = true, -- splitting a new window below the current one
    splitright = true, -- splitting a new window at the right of the current one
    tabstop = 2, -- number of space in a tab
    termguicolors = true, -- enable 24-bit RGB color in the TUI
    timeoutlen = 500, -- shorten key timeout length a little bit for which-key
    title = true, -- set terminal title to the filename and path
    undofile = true, -- enable persistent undo
    updatetime = 300, -- length of time to wait before triggering the plugin
    virtualedit = "block", -- allow going past end of line in visual block mode
    writebackup = false, -- disable making a backup before overwriting a file
  },
  g = {
    neovide_hide_mouse_when_typing = true,
    neovide_confirm_quit = true,
    neovide_scroll_animation_length = 0.5,
    autoformat_enabled = true,
    cmp_enabled = true,
    autopairs_enabled = true,
    diagnostics_mode = 3,
    icons_enabled = true,
    ui_notifications_enabled = true,
    max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files
    codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
    highlighturl_enabled = true, -- highlight URLs by default
    inlay_hints_enabled = false, -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
    lsp_handlers_enabled = true, -- enable or disable default vim.lsp.handlers (hover and signature help)
    semantic_tokens_enabled = true, -- enable or disable LSP semantic tokens on startup
    git_worktrees = nil, -- enable git integration for detached worktrees (specify a table where each entry is of the form { toplevel = vim.env.HOME, gitdir=vim.env.HOME .. "/.dotfiles" })
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
