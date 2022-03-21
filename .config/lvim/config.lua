lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.bufferline.active = true

lvim.lsp.automatic_servers_installation = true
--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- lvim.lang.python.setup.cmd = {"/home/mbarry/.local/share/nvim/lsp_servers/pylsp/venv/bin"}
-- lvim.lsp.automatic_servers_installation = false
vim.list_extend(lvim.lsp.override, { "pyright", "pylsp" })

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.bicep = {
  install_info = {
    url = "~/repos/tree-sitter-bicep", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "bicep",
}

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.hcl = {
  filetype = "hcl", "terraform",
}

local opts = {
  settings = {
    pylsp = {
      plugins = {
        pylsp_mypy = { enabled = true },
        pylsp_black = { enabled = true },
      }
    },
  }
}
require("lvim.lsp.manager").setup("pylsp", opts)
--require("dapui").setup()

lvim.builtin.dap.active = true
-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["J"] = "mzJ`z"
lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.normal_mode["<M-i>"] = "<Esc><Cmd>ToggleTerm<CR>"
lvim.keys.insert_mode["<M-i>"] = "<Esc><Cmd>ToggleTerm<CR>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

  lvim.builtin.which_key.mappings["dI"] = {
    "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Inspect Variable",
  }

  lvim.builtin.which_key.mappings["dU"] = {
    "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI",
  }

  lvim.builtin.which_key.mappings["sw"] = {
    "<cmd>Telescope vw live_grep<cr>", "Search Wiki",
  }

lvim.builtin.which_key.mappings["G"] = {
  name = "Git Fugitive",
  a = {"<cmd>Git add .<CR>", "Git add all"},
  s = {"<cmd>Git status<CR>", "Git status"},
  d = {"<cmd>Gvdiffsplit<CR>", "Git diff"},
  G = {"<cmd>Git<CR>", "Interactive Git"}
}

lvim.builtin.which_key.mappings["n"] = {
  name = "Notes - VimWiki",
}
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { exe = "black", filetypes = { "python" } },
--   { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
    {"dracula/vim"},
    {"tpope/vim-fugitive"},
    {"tpope/vim-repeat"},
    {
      "tpope/vim-surround",
      opt = false,
      event = "VimEnter",
      keys = {"c", "d", "y"}
    },
    {"shaunsingh/nord.nvim"},
    {"projekt0n/github-nvim-theme"},
    {
      "ggandor/lightspeed.nvim",
      opt = false,
      event = "BufRead",
    },
    {
      "nvim-telescope/telescope-fzy-native.nvim",
      run = "make",
      event = "BufRead",
    },
    {
      "metakirby5/codi.vim",
      cmd = "Codi",
    },
    {"aserowy/tmux.nvim"},
    {"ElPiloto/telescope-vimwiki.nvim"},
    {"mfussenegger/nvim-dap-python"},
    {"rcarriga/nvim-dap-ui"},
    {"tvaintrob/bicep.vim"},
    {"michal-h21/vimwiki-sync"},
    {"folke/tokyonight.nvim",
      tokyonight_style = "storm"},
    {
      "vimwiki/vimwiki",
      config = function()
        vim.cmd ("let g:vimwiki_map_prefix = '<Leader>n'")
        vim.cmd ("let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]")
      end,
    },
}

require("luasnip").filetype_extend("vimwiki", {"markdown"})
require("luasnip/loaders/from_vscode").load { paths = { "~/.snippets" } }
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
lvim.builtin.treesitter.indent = { enable = true, disable = { "python" } }
vim.o.cmdheight = 1
vim.g.leetcode_browser = "chrome"
