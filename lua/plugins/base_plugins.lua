return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  -- { 'folke/which-key.nvim', opts = {} },

  -- Help with comemnting visual regiones/lines
  -- using `gc`
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
      require('Comment').setup(
        {
          ignore = '^$',
        }
      )
    end
  },
}
