local plugins = {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
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
    "robitx/gp.nvim",
    enable = true,
    lazy = false,
    config = function()
      require("gp").setup(require "custom.plugins.configs.gp")

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   event = { "User AstroFile", "InsertEnter" },
  --   dependencies = { "kevinhwang91/promise-async" },
  --   opts = {
  --     preview = {
  --       mappings = {
  --         scrollB = "<C-b>",
  --         scrollF = "<C-f>",
  --         scrollU = "<C-u>",
  --         scrollD = "<C-d>",
  --       },
  --     },
  --     provider_selector = function(_, filetype, buftype)
  --       local function handleFallbackException(bufnr, err, providerName)
  --         if type(err) == "string" and err:match "UfoFallbackException" then
  --           return require("ufo").getFolds(bufnr, providerName)
  --         else
  --           return require("promise").reject(err)
  --         end
  --       end
  --
  --       return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
  --         or function(bufnr)
  --           return require("ufo")
  --             .getFolds(bufnr, "lsp")
  --             :catch(function(err)
  --               return handleFallbackException(bufnr, err, "treesitter")
  --             end)
  --             :catch(function(err)
  --               return handleFallbackException(bufnr, err, "indent")
  --             end)
  --         end
  --     end,
  --   },
  -- },
}

return plugins
