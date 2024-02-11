---@type MappingsTable
local M = {}

-- local sections = {
--   f = { desc = get_icon("Search", 1, true) .. "Find" },
--   p = { desc = get_icon("Package", 1, true) .. "Packages" },
--   l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
--   u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
--   b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
--   bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
--   d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
--   g = { desc = get_icon("Git", 1, true) .. "Git" },
--   S = { desc = get_icon("Session", 1, true) .. "Session" },
--   t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
-- }
--
--
M.whichkey = {
  plugin = true,

  n = {
    ["<leader>WK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>Wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
    ["<leader>fN"] = { "<cmd>Telescope noice<cr>", "Noice" },
    ["<leader>fn"] = { "<cmd>Telescope notify<cr>", "Notify" },
    ["<leader>fd"] = { "<cmd>Telescope diagnostics<cr>", "Notify" },

    -- ["<leader>g"] = { function() end, "+ 󰊢 Git" },
    ["<leader>W"] = { function() end, "Workspace & Whickkey" },
    ["<leader>Wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>Wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>Wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },

    ["<leader>w"] = { ":w<cr>", "Write file" },
    -- ["<leader>w"] = { ":w<cr>", "Write file", opts = { nowait = true } },
    -- ["<leader>e"] = { ":NvimTreeToggle<cr>", "Toggle explorer", opts = { nowait = true}},
    ["<leader>r"] = { ":b#<cr>", "Last buffer", opts = { nowait = true } },
    ["<leader>Q"] = { ":qa<cr>", "Close all buffers", opts = { nowait = true } },
    ["<leader>gg"] = { ":LazyGit<cr>", "Lazy Git", opts = { nowait = true } },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "Hover symbol details",
    },

    ["<leader>a"] = { "<cmd>A<cr>", "Alternate File", opts = { nowait = true } },

    ["|"] = { "<cmd>vsplit<cr>", "Vertical split" },
    ["-"] = { "<cmd>split<cr>", "Horiz. split" },

    ["<leader>l"] = { function() end, "LSP" },
    ["<leader>lc"] = {
      function()
        vim.lsp.codelens.run()
      end,
      "Run codelens",
    },
    ["<leader>nl"] = {
      function()
        require("noice").cmd "last"
      end,
      "Noice last",
    },
    ["<leader>nh"] = {
      function()
        require("noice").cmd "history"
      end,
      "Noice hitory",
    },

    -- Noice
    ["<leader>n"] = { function() end, "Noice" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  i = {
    -- copilot
    ["<C-Enter>"] = { "<cmd>:Copilot suggestion accept<cr>", "Accept Suggestion" },
    ["<C-Down>"] = { "<cmd>:Copilot suggertion next<cr>", "Next Suggestion" },
    ["<C-Up>"] = { "<cmd>:Copilot suggertion prev<cr>", "Next Suggestion" },
    ["<C-p>"] = { "<cmd>:Copilot panel<cr>", "Copilot Panel" },
  },

  -- more keybinds!
}

vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })

return M
