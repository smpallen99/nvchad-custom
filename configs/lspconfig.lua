local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "volar" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- `on_attach` callback will be called after a language server
-- instance has been attached to an open buffer with matching filetype
-- here we're setting key mappings for hover documentation, goto definitions, goto references, etc
-- you may set those key mappings based on your own preference
local on_attach_ex = function(client, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
  vim.lsp.codelens.refresh()

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local nil_buf_id = 999999
local term_buf_id = nil_buf_id

local get_cursor_position = function()
  local rowcol = vim.api.nvim_win_get_cursor(0)
  local row = rowcol[1] - 1
  local col = rowcol[2]

  return row, col
end

local function test(command)
  local row, _col = get_cursor_position()
  local args = command.arguments[1]

  -- delete the current buffer if it's still open
  if vim.api.nvim_buf_is_valid(term_buf_id) then
    vim.api.nvim_buf_delete(term_buf_id, { force = true })
    term_buf_id = nil_buf_id
  end

  vim.cmd "botright new | lua vim.api.nvim_win_set_height(0, 15)"
  term_buf_id = vim.api.nvim_get_current_buf()
  vim.opt_local.number = false
  vim.opt_local.cursorline = false

  local cmd = "mix test " .. args.filePath

  -- add the line number if it's for a specific describe/test block
  if args.describe or args.testName then
    cmd = cmd .. ":" .. (row + 1)
  end

  vim.fn.termopen(cmd, {
    on_exit = function(_jobid, exit_code, _event)
      if exit_code == 0 then
        vim.api.nvim_buf_delete(term_buf_id, { force = true })
        term_buf_id = nil_buf_id
        vim.notify("Success: " .. cmd, vim.log.levels.INFO)
      else
        vim.notify("Fail: " .. cmd, vim.log.levels.ERROR)
      end
    end,
  })

  vim.cmd [[wincmd p]]
end

lspconfig.elixirls.setup {
  cmd = { "/usr/local/bin/elixir-ls" },
  on_attach = on_attach_ex,
  capabilities = capabilities,
  -- default settings, use the `settings` function to override settings
  elixirLS = {
    dialyzerEnabled = true,
    fetchDeps = false,
    enableTestLenses = true,
    suggestSpecs = true,
    commands = {
      ["elixir.lens.test.run"] = test,
    },
  },
}

--
-- lspconfig.pyright.setup { blabla}
