-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<Tab>", "<cmd>silent! wincmd w<cr>", { desc = "Перейти к следующему окну" })

-- Это костыль чтобы при переключении окна, фокус не попадал на warning. 
vim.keymap.set("n", "<Tab>", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.cmd("wincmd w")
end, { noremap = true, silent = true })
