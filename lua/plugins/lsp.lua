return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },

  config = function()
    local servers = {
      bashls = {},

      clangd = {
      	filetypes = { 'c', 'cpp' },
      },

      lua_ls = {
	settings = {
	  Lua = {
	    diagnostics = {
	      globals = { 'vim' },
	    },
	  },
	},
      },

      pyright = {},

      sqlls = {},

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
       	  server.capabilities = vim.tbl_deep_extend('force', {}, server.capabilities or {})

       	  require('lspconfig')[server_name].setup(server)
       	end
      }
    })
  end,
}
