local M = {}

function M.setup()
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.signcolumn = "no"
  vim.opt.foldcolumn = "0"

  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.breakindent = true
  vim.opt.showbreak = "  "

  vim.opt.spell = true
  vim.opt.spelllang = { "en", "sv" }

  vim.opt.conceallevel = 2
  vim.opt.concealcursor = "nc"

  vim.opt.colorcolumn = ""
  vim.opt.textwidth = 0
  vim.opt.cursorline = false
  vim.opt.list = false

  vim.opt.laststatus = 3
  vim.opt.cmdheight = 1
  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 8

  vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(args)
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.breakindent = true
      vim.opt_local.spell = true
      vim.opt_local.spelllang = { "en", "sv" }
      vim.opt_local.conceallevel = 2
      vim.opt_local.textwidth = 0
      vim.opt_local.colorcolumn = ""
      vim.opt_local.signcolumn = "no"
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.cursorline = false
      vim.opt_local.list = false

      pcall(vim.diagnostic.enable, false, { bufnr = args.buf })
      pcall(function()
        require("gitsigns").detach(args.buf)
      end)
    end,
  })

  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

  pcall(require, "core.note_keymaps")
  pcall(require, "plugin.dirvish_notes")
  pcall(require, "plugin.lualine_notes")
  pcall(require, "core.writing_layout")
  pcall(function()
    require("core.writing_layout").setup()
  end)
end

return M
