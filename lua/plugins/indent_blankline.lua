-- Adding indentation guidelines to neovim

return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  opt = {},
  config = function()
    require('ibl').setup()
  end
}
