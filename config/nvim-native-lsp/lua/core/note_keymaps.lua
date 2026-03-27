local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

-- Toggle zen-mode (centered page with equal margins)
map("<leader>z", "<cmd>ZenMode<cr>", "Toggle zen mode")
