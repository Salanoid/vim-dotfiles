-- In lua/config/lazy.lua enhance this lines:
-- import/override with your plugins
-- { import = "plugins" },
-- { import = "plugins.custom" }

return {
  -- ========== Core Navigation ==========
  -- Disable Neo-tree and other UI plugins for tabs/windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "romgrk/barbar.nvim",
    enabled = false,
  },
  {
    "folke/edgy.nvim",
    enabled = false,
  },

  -- Harpoon for quick file navigation
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
      vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Harpoon Add File" })
      vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon Menu" })
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          require("harpoon.ui").nav_file(i)
        end, { desc = "Navigate to Harpoon File " .. i })
      end
    end,
  },

  -- ========== AI & Chat Integration ==========
  -- Copilot for AI-powered code suggestions
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  -- Copilot Chat for interactive AI assistance
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim" },
    opts = {
      show_help = "yes",
      question_header = "## User",
      answer_header = "## Copilot",
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", desc = "Code Review with Copilot" },
      { "<leader>cp", "<cmd>CopilotChatPrompt<CR>", desc = "Copilot Prompt" },
    },
  },

  -- ========== Language Support ==========
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby", "elixir", "rust", "javascript", "typescript", "clojure",
        "heex", "eex", "tsx", "lua", "vim", "bash", "markdown", "json",
      },
    },
  },
  -- Mason for managing LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ruby_lsp", "elixirls", "rust_analyzer", "tsserver",
        "clojure_lsp", "denols", "tailwindcss", "html", "cssls",
      },
    },
  },
  -- Elixir language support
  {
    "mhanberg/elixir.nvim",
    ft = "elixir",
    config = function()
      require("elixir").setup({
        nextls = { enable = true },
        credo = {},
      })
    end,
  },
  -- Rust tools
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup()
    end,
  },
  -- Clojure tools
  {
    "Olical/conjure",
    ft = "clojure",
    config = function()
      vim.g["conjure#mapping#prefix"] = "<leader>c"
    end,
  },

  -- ========== Code Review & Collaboration ==========
  -- Diffview for reviewing code changes
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diff View" },
      { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close Diff View" },
    },
  },
  -- Gitlinker for sharing code
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({ mappings = "<leader>gy" })
    end,
  },
  -- LSP Lines for better diagnostics
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_text = false })
      vim.keymap.set("n", "<leader>ul", require("lsp_lines").toggle, { desc = "Toggle LSP Lines" })
    end,
  },

  -- ========== Quality of Life ==========
  -- Auto-tag for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "heex", "eex" },
    config = true,
  },
  -- Emmet for fast HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "heex", "javascript", "typescript" },
  },
}
