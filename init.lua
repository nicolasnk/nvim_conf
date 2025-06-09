vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true


-- Installing Lazy vim and all the plugins subsequently
require 'lazyvim'

-- [[ Setting options ]]
require 'options'

-- My basic keymaps
require 'keymaps'
