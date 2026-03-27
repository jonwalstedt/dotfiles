vim.api.nvim_create_autocmd("FileType", {
  pattern = "dirvish",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"

    -- Visuell vänstermarginal utan att ändra buffer-innehållet
    vim.opt_local.statuscolumn = string.rep(" ", 4)

    -- Lite renare känsla
    vim.opt_local.cursorline = false
    vim.opt_local.list = false
  end,
})
