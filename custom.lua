-- in lua/config/lazy.lua enhance this lines:
-- import/override with your plugins
-- { import = "plugins" },
-- { import = "plugins.custom" }

return {
  -- ========== core navigation ==========
  -- disable bufferline, replace it with harpoon
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup()
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- harpoon for quick file navigation
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = true,
          enter_on_sendcmd = true,
        },
      })
      vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "harpoon add file" })
      vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "harpoon menu" })
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          require("harpoon.ui").nav_file(i)
        end, { desc = "navigate to harpoon file " .. i })
      end
    end,
  },

  -- ========== ai & chat integration ==========
  -- copilot for ai-powered code suggestions
  {
    "github/copilot.vim",
    event = "insertenter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<c-j>", 'copilot#accept("<cr>")', { silent = true, expr = true })
    end,
  },
  -- copilot chat for interactive ai assistance
  {
    "copilotc-nvim/copilotchat.nvim",
    dependencies = { "github/copilot.vim" },
    opts = {
      show_help = "yes",
      question_header = "## user",
      answer_header = "## copilot",
    },
    keys = {
      { "<leader>cc", "<cmd>copilotchattoggle<cr>", desc = "toggle copilot chat" },
      { "<leader>cr", "<cmd>copilotchatreview<cr>", desc = "code review with copilot" },
      { "<leader>cp", "<cmd>copilotchatprompt<cr>", desc = "copilot prompt" },
    },
  },

  -- ========== language support ==========
  -- treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby",
        "elixir",
        "rust",
        "javascript",
        "typescript",
        "clojure",
        "heex",
        "eex",
        "tsx",
        "lua",
        "vim",
        "bash",
        "markdown",
        "json",
      },
    },
  },
  -- mason for managing lsp servers
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ruby_lsp",
        "elixirls",
        "rust_analyzer",
        "tsserver",
        "clojure_lsp",
        "denols",
        "tailwindcss",
        "html",
        "cssls",
      },
    },
  },
  -- elixir language support
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
  -- rust tools
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup()
    end,
  },
  -- clojure tools
  {
    "olical/conjure",
    ft = "clojure",
    config = function()
      vim.g["conjure#mapping#prefix"] = "<leader>c"
    end,
  },

  -- ========== code review & collaboration ==========
  -- diffview for reviewing code changes
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>diffviewopen<cr>", desc = "open diff view" },
      { "<leader>gd", "<cmd>diffviewclose<cr>", desc = "close diff view" },
    },
  },
  -- gitlinker for sharing code
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({ mappings = "<leader>gy" })
    end,
  },
  -- lsp lines for better diagnostics
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_text = false })
      vim.keymap.set("n", "<leader>ul", require("lsp_lines").toggle, { desc = "toggle lsp lines" })
    end,
  },

  -- ========== quality of life ==========
  -- auto-tag for html and jsx
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "heex", "eex" },
    config = true,
  },
  -- emmet for fast html/css
  {
    "mattn/emmet-vim",
    ft = { "html", "heex", "javascript", "typescript" },
  },
  -- undotree for undo diffview
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- Load the plugin only when using its keybinding:
      { "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
