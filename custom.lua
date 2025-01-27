-- In lua/config/lazy.lua enhance this lines:
-- import/override with your plugins
-- { import = "plugins" },
-- { import = "plugins.custom" }

return {
  -- ========== Core Navigation ==========
  -- Disable Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- Disable tab and window management plugins
  {
      "akinsho/bufferline.nvim", -- Bufferline for tabs
      enabled = false,
  },
  {
      "romgrk/barbar.nvim", -- Barbar for tabs (if used)
      enabled = false,
  },
  {
      "folke/edgy.nvim", -- Edgy for window management
      enabled = false,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = true,
          enter_on_sendcmd = true,
        },
      })
      vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Harpoon Add" })
      vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon Menu" })
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>"..i, function() require("harpoon.ui").nav_file(i) end, { desc = "Harpoon File "..i })
      end
    end,
  },

  -- ========== AI & Chat ==========
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim" },
    opts = {
      show_help = "yes",
      question_header = "## User ",
      answer_header = "## Copilot ",
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Copilot Chat" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", desc = "Code Review" },
      { "<leader>cp", "<cmd>CopilotChatPrompt<CR>", desc = "Copilot Prompt" },
    },
  },

  -- ========== Language Support ==========
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby", "elixir", "rust", "javascript", "typescript", "clojure",
        "heex", "eex", "tsx", "lua", "vim", "bash", "markdown", "json"
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ruby_lsp", "elixirls", "rust_analyzer", "tsserver",
        "clojure_lsp", "denols", "tailwindcss", "html", "cssls"
      },
    },
  },
  {
    "mhanberg/elixir.nvim",
    ft = "elixir",
    config = function()
      require("elixir").setup({ nextls = { enable = true }, credo = {} })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function() require("rust-tools").setup() end,
  },
  {
    "Olical/conjure",
    ft = "clojure",
    config = function() vim.g["conjure#mapping#prefix"] = "<leader>c" end,
  },

  -- ========== Code Review & Collaboration ==========
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
      { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close Diff" },
    },
  },
  -- {
  --   "andrewferrier/review.nvim",
  --   config = function()
  --     require("review").setup({
  --       keymaps = {
  --         add_annotation = "<leader>ca",
  --         goto_next_annotation = "]a",
  --         goto_prev_annotation = "[a",
  --       }
  --     })
  --   end,
  -- },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({ mappings = "<leader>gy" })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
          vim.diagnostic.config({ virtual_text = false })
          vim.keymap.set("n", "<leader>ul", require("lsp_lines").toggle, { desc = "Toggle LSP Lines" })
        end,
      },

  -- ========== Testing & Debugging ==========
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/neotest-ruby",
  --     "jfpedroza/neotest-elixir",
  --     "rouge8/neotest-rust",
  --     "marilari88/neotest-vitest",
  --   },
  --   config = function()
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-ruby"),
  --         require("neotest-elixir"),
  --         require("neotest-rust"),
  --         require("neotest-vitest"),
  --       }
  --     })
  --     vim.keymap.set("n", "<leader>tt", "<cmd>Neotest run<CR>", { desc = "Test Run" })
  --     vim.keymap.set("n", "<leader>tf", "<cmd>Neotest run-file<CR>", { desc = "Test File" })
  --   end,
  -- },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap").adapters.ruby = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "bundle",
          args = { "exec", "rdbg", "-n", "--open", "--port", "${port}", "-c", "--", "bundle", "exec", "rails", "s" }
        }
      }
    end,
  },

  -- ========== Quality of Life ==========
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "heex", "eex" },
    config = true,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "heex", "javascript", "typescript" },
  },
  -- {
  --   "gorbit99/codewindow.nvim",
  --   config = function() require("codewindow").setup().apply_default_keybinds() end,
  -- },
  -- {
  --   "tenxsoydev/nx.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   opts = { nx_runnable_filetypes = { "ruby", "elixir", "typescript" } },
  -- },
}
