return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
      	return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'folke/lazydev.nvim',
  },

  opts = {
    keymap = {
      preset = 'default',
    },
  },

  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },

  snippets = {
     preset = 'luasnip',
  },

  fuzzy = {
    implementation = 'lua'
  },

  signature = {
    enabled = true
  },
}
