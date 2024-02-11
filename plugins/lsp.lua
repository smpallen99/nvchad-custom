local overrides = require "custom.plugins.configs.overrides"

return {
  --
  {
    "smpallen99/elixir-projectionist.nvim",
    enable = true,
    lazy = false,
    config = function()
      require("elixir-projectionist").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    lazy = false,
    config = function()
      require "custom.plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.plugins.configs.conform"
    end,
  },
  {
    "tpope/vim-projectionist",
    enabled = true,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
  },
  {
    "smpallen99/nvim-coverage",
    enabled = true,
    -- lazy = false,
    event = "BufEnter *.ex",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  },
}
