return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
  },
  config = function()
    -- bind leader g to open neogit
    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Neogit<CR>', { noremap = true, silent = true })
  end,
}
