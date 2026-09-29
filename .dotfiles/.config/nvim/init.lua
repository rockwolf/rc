--------------------------------------------------------------------------------
-- Key remapping
--------------------------------------------------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- See `:help vim.keymap.set()`
vim.keymap.set('n', "<leader>ex", vim.cmd.Ex)

--vim.keymap.set({'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({'n', 'v'}, '<A-t>', '<cmd>Neotree toggle<cr>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--------------------------------------------------------------------------------
-- Lazy package manager
--------------------------------------------------------------------------------
-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- NOTE: Here is where you install your plugins.
-- You can configure plugins using the `config` key.
--------------------------------------------------------------------------------
-- You can also configure plugins after the setup call,
-- as they will be available in your neovim runtime.
require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  --------------------------------------------------------------------------------
  -- LSP: language server
  --------------------------------------------------------------------------------
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      --{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      --'folke/neodev.nvim',
    },
  },

  --------------------------------------------------------------------------------
  -- Which-key: Useful plugin to show you pending keybinds
  --------------------------------------------------------------------------------
  {
    'folke/which-key.nvim', opts = {}
  },

  --------------------------------------------------------------------------------
  -- Theme
  --------------------------------------------------------------------------------
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      contrast = "hard"
    },
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  --------------------------------------------------------------------------------
  -- Comment: "gc" to comment visual regions/lines 
  --------------------------------------------------------------------------------
  {
    'numToStr/Comment.nvim', opts = {}
  },

  --------------------------------------------------------------------------------
  -- Telescope: Fuzzy Finder (files, lsp, etc)
  --------------------------------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  --------------------------------------------------------------------------------
  -- Treesitter TextObjects
  --------------------------------------------------------------------------------
 { 
   "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      -- put your config here
    end, 
  },

  --------------------------------------------------------------------------------
  -- Treesitter
  --------------------------------------------------------------------------------
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  --------------------------------------------------------------------------------
  -- Neotree
  --------------------------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  },

  --------------------------------------------------------------------------------
  -- vim-table-mode
  --------------------------------------------------------------------------------
  {
    'dhruvasagar/vim-table-mode'
  },

  --------------------------------------------------------------------------------
  -- Orgmode
  --------------------------------------------------------------------------------
  {
    'nvim-orgmode/orgmode',
    tag = "0.7.0",
    dependencies = { },
    event = 'VeryLazy',
    config = function()
      -- Setup treesitter
      --require('nvim-treesitter.configs').setup({
      --  highlight = {
      --    enable = false,
      --    additional_vim_regex_highlighting = { 'org' },
      --  },
      --  ensure_installed = { 'org' },
      --})

      -- Setup orgmode
      require('orgmode').setup({
        org_todo_keywords = {'TODO', 'IN_PROGRESS', 'DONE'},
        org_todo_keyword_faces = {
            IN_PROGRESS = ':foreground #b8bb26', -- blue = #83a598 
            TODO = ':foreground #fb4934'
        },
        org_default_notes_file = os.getenv('HOME') .. '/doc/personal/pkm/doc/index.org',
        org_agenda_files = os.getenv('HOME') .. '/doc/personal/pkm/doc/*.org',
        org_agenda_custom_commands = {
          -- "c" is the shortcut that will be used in the prompt
          c = {
            description = 'Kanban view', -- Description shown in the prompt for the shortcut
            types = {
              {
                type = 'tags_todo', -- Type can be agenda | tags | tags_todo
                match = '+TODO="IN_PROGRESS"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
                org_agenda_overriding_header = 'IN_PROGRESS',
              },
              {
                type = 'tags_todo', -- Type can be agenda | tags | tags_todo
                match = '+TODO="TODO"', --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
                org_agenda_overriding_header = 'TODO',
              },
            }
          }
        },
        mappings = {
          capture = {
            -- Behave like Emacs' orgmode capture
            org_capture_finalize = "<leader>ncc",
          },
          org = {
            org_toggle_checkbox = "<leader>cc",
          }
        },
        org_adapt_indentation = false
      })
    end,
  },

  --------------------------------------------------------------------------------
  -- Org-roam
  --------------------------------------------------------------------------------
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.2.0",
    dependencies = {
    {
        "nvim-orgmode/orgmode",
        tag = "0.7.0",
      },
    },
    config = function()
      require("org-roam").setup({
        database = {
          path = roamdb
        },
        directory = os.getenv('HOME') .. "/doc/personal/pkm/doc",
        org_files = {
          --os.getenv('HOME') .. "/doc/personal/import/*.org"
        },
    })
    end
  }
}, {})

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
-- See `:help vim.o`

-- Show special chars
vim.opt.list = false
vim.opt.listchars:append "space:∙,eol:↵"

-- Set highlight on search
vim.o.hlsearch = false

-- Line wrapping
vim.opt.wrap = true

-- Indent
vim.opt.smartindent = false
vim.opt.autoindent = false
vim.opt.cindent = false

-- Make line numbers default
vim.wo.number = true

-- Statusline
--vim.o.statusline = [[%<%f %h%m%r %y%=%{v:register} %-14.(%l,%c%V%) %P]]
vim.o.laststatus = 0

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = false

-- Save undo history
vim.o.undofile = false 

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--------------------------------------------------------------------------------
-- Telescope configuration
--------------------------------------------------------------------------------
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[F]ind [G]it' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').live_grep, { desc = '[G]rep [F]iles' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })

--------------------------------------------------------------------------------
-- Treesitter configuration
--------------------------------------------------------------------------------
-- See `:help nvim-treesitter`
--require('nvim-treesitter').install { 'org', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' }

--------------------------------------------------------------------------------
-- Treesitter grammar for org
--------------------------------------------------------------------------------
--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.org = {
--  install_info = {
--    url = 'https://github.com/milisims/tree-sitter-org',
--    revision = 'main',
--    files = { 'src/parser.c', 'src/scanner.c' },
--  },
--  filetype = 'org',
--}

--------------------------------------------------------------------------------
-- LSP configuration
--------------------------------------------------------------------------------
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- omnisharp = {},
  -- gopls = {},
  -- pyright = {},
  --rust_analyzer = {},
  -- tsserver = {},
  --html = { filetypes = { 'html' } },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
