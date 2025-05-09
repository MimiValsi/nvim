local map = vim.keymap.set

map('n', '<leader>e', ':Oil<cr>', { desc = 'Explorer' })
map('n', '<leader>w', ':w<cr>', { desc = 'save file' })
map('n', '<leader>q', ':q<cr>', { desc = 'save file' })
map('n', ';', ':', { desc = 'swap : to ;' })
map('n', '<C-i>', ':tabn<cr>', { desc = 'go to next tab' })
map('n', '<C-o>', ':tabp<cr>', { desc = 'go to prev tab' })
map('n', '<leader>T', ':tab new<cr>', { desc = 'New tab' })
map('n', '<leader>t', ':tab ter<cr>', { desc = 'New tab with terminal' })
map('n', '<leader>ra',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'replace the word everywhere in the file/buffer' })

map('n', 'Q', ':noh<cr>', { desc = 'Disable Q and cleans mini buffer from messages' })
map('n', '<leader>V', ':vert terminal<cr>', { desc = 'Open vertical in vertical split' })
map('n', '<leader>v', ':vsplit<cr>', { desc = 'Vertical split' })
map('n', '<leader>db', ':1, .-bdelete<cr>', { desc = 'Delete all buffers except tabbed' })
map('n', '<leader>x', ':!chmod +x %<CR>', { silent = true })
map('n', '<leader>cd', ':cd %:p:h<cr>')
map('n', '<F4>', '<cmd>:cd %:p:h<cr>')

map('n', '<leader>ra',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'replace the word everywhere in the file/buffer' })

map('n', '<leader>d', '"_dd')
map('n', '<leader>fd', ':Trouble diagnostics toggle<cr>')

-- dvorak
--map('n', 'h', '<down>')
--map('n', 'd', '<left>')
--map('n', 't', '<up>')
--map('n', 'n', '<right>')
--map('i', '<C-d>', '<left>')
--map('i', '<C-h>', '<down>')
--map('i', '<C-t>', '<up>')
--map('i', '<C-n>', '<right>')

-- insert mode
map('i', '<C-h>', '<left>', { desc = 'Move left in insert mode'})
map('i', '<C-j>', '<down>', { desc = 'Move down in insert mode'})
map('i', '<C-k>', '<up>', { desc = 'Move up in insert mode'})
map('i', '<C-l>', '<right>', { desc = 'Move right in insert mode'})
map('i', '<C-b>', '<ESC>^i', { desc = 'Go to begining of line' })
map('i', '<C-e>', '<End>', { desc = 'Go to end of line' })
map('i', '<C-g>', '<Esc>')

-- visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", {
  desc = 'make the selected hightlighted line and go up one line, indent if possible and highlight it again',
})

map('v', 'K', ":m '<-2<CR>gv=gv", {
  desc = 'make the selected hightlighted line and go up one line, indent if possible and highlight it again',
})

-- terminal
map('t', '<C-j><C-k>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
