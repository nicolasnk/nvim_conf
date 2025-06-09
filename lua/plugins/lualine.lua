-- set lualine as the status line 
-- Probably need to add a dependency to tokyonight here since this is using it


return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = false,
      theme = 'tokyonight-moon',
      component_separators = '|',
      section_separators = '',
    },
  },
}
