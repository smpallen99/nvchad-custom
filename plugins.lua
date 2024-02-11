local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

local plugins = {

  -- Override plugin definition options

  {
    "smpallen99/elixir-projectionist.nvim",
    enable = true,
    lazy = false,
    config = function()
      require("elixir-projectionist").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        panel = { enabled = false },
        suggestion = { enabled = false, auto_trigger = true },
      }
    end,
  },
  -- after much trouble shooting, I found this config in
  -- https://www.lazyvim.org/extras/coding/copilot
  -- I had to copy the more involed config below
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require "copilot_cmp"
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      on_attach = function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter {}
        end
      end
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require "copilot_cmp"
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          on_attach = function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter {}
            end
          end
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    lazy = false,
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
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
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },
  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   version = "*",
  --   enabled = true,
  --   lazy = false,
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require "elixir"
  --     local elixirls = require "elixir.elixirls"
  --
  --     elixir.setup {
  --       nextls = {
  --         enable = false, -- defaults to false
  --         enabled = false,
  --         port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
  --         cmd = "/usr/local/bin/nextls", -- path to the executable. mutually exclusive with `port`
  --         init_options = {
  --           mix_env = "dev",
  --           mix_target = "host",
  --           experimental = {
  --             completions = {
  --               enable = false -- control if completions are enabled. defaults to false
  --             }
  --           }
  --         },
  --         on_attach = function(client, bufnr)
  --           -- custom keybinds
  --         end
  --       },
  --       credo = {
  --         enable = false, -- defaults to true
  --         port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
  --         cmd = "/usr/local/bin//nextls", -- path to the executable. mutually exclusive with `port`
  --         version = "0.1.0-rc.3", -- version of credo-language-server to install and use. defaults to the latest release
  --         on_attach = function(client, bufnr)
  --           -- custom keybinds
  --         end
  --       },
  --       elixirls = {
  --         enable = true,
  --         -- specify a repository and branch
  --         repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
  --         branch = "mh/all-workspace-symbols", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
  --         tag = "v0.14.6", -- defaults to nil, mutually exclusive with the `branch` option
  --
  --         -- alternatively, point to an existing elixir-ls installation (optional)
  --         -- not currently supported by elixirls, but can be a table if you wish to pass other args `{"path/to/elixirls", "--foo"}`
  --         -- cmd = "/usr/local/bin/elixir-ls.sh",
  --         cmd = "/usr/local/bin/elixir-ls",
  --
  --         -- default settings, use the `settings` function to override settings
  --         settings = elixirls.settings {
  --           dialyzerEnabled = true,
  --           fetchDeps = false,
  --           enableTestLenses = true,
  --           suggestSpecs = true,
  --         },
  --         on_attach = function(client, bufnr)
  --           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --
  --           vim.keymap.set("n", "gd", vim.lsp.buf.definition())
  --         end
  --       }
  --     }
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
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

return plugins
