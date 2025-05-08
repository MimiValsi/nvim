return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      bashls = {},

      clangd = {
      	filetypes = { 'c', 'cpp' },
      },

      html = {},

      jsonls = {
      	on_new_config = function (new_config)
      	  new_config.settings.json.schemas = new_config.settings.json.schemas or {}
	  vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      	end,
      	settings = {
	  json = {
	    format = {
	      enable = true,
	    },
	    validate = { enable = true },
	  },
      	},
      },

      lua_ls = {
	settings = {
	  Lua = {
	    completion = {
	      callSnippet = 'Replace',
	    },
	    diagnostics = {
	      globals = { 'vim' },
	    },
	  },
	},
      },

      pyright = {},

      sqlls = {},

      -- sqlls = {},
      postgrestools = {
	require('lspconfig').postgres_lsp.setup {
	  cmd = { "postgrestools", "lsp-proxy" },
	  filetypes = { "sql" },
	  root_markers = { "postgrestools.jsonc" },
	},

      },

      zls = {},

    }

    require('mason').setup({})

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- lua
      'stylua',
      'lua-language-server',

      -- go
      'goimports-reviser',
      'golines',
      'gopls',

      -- C/C++
      'clangd',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
       handlers = {
       	function(server_name)
       	  local server = servers[server_name] or {}
       	  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

       	  require('lspconfig')[server_name].setup(server)
       	end
      }
    })
  end,
}
