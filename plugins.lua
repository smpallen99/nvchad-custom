local overrides = require "custom.plugins.configs.overrides"

---@type NvPluginSpec[]

local plugins = {

  -- Install a plugin
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

local core = require "custom.plugins.core"
local dap = require "custom.plugins.dap"
local lsp = require "custom.plugins.lsp"
local ui = require "custom.plugins.ui"
local git = require "custom.plugins.git"

return vim.tbl_deep_extend("force", plugins, core, dap, lsp, ui, git)
