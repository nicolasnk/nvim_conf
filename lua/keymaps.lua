-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})


-- Deleting to an empty register. Do not want to clog the other reg
vim.keymap.set('v', '<leader>d', '"_d', { desc = "Deleting to empty reg" })
vim.keymap.set('n', '<leader>dd', '"_dd', { desc = "Deleting to empty reg" })
vim.keymap.set('n', '<leader>diw', '"_diw', { desc = "Deleting word to empty reg" })

-- Yanking in the system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank line to system clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to system clipboard' })

-- Yanking the entire content of a file to the clipboard
vim.keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Yank entire file to system clipboard' })

-- Pasting from the clipboard
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste before cursor from system clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste after cursor from system clipboard' })

-- Move code using J and K
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selected text up' })
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selected text down' })

vim.keymap.set('n', '<A-a>', 'dd', { desc = ' can be used to delete a line' })

-- local function to set keymaps
local function set_keymap(mode, lhs, rhs, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- set keymap to format files
set_keymap('n', '<leader>f', ':Format <CR>')


-- Going to the file directory
set_keymap('n', '<leader>fd', ':Ex <CR>', { noremap = true, silent = true, desc = "Current file/buffer directory" })
