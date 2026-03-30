local M = {}

local function set_terminal_bg(color)
  io.write("\027]11;" .. color .. "\007")
  io.flush()
end

local function reset_terminal_bg()
  io.write("\027]111\007")
  io.flush()
end

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
      -- Ensure treesitter highlighting is active (required for inline rendering)
      vim.treesitter.start(args.buf, "markdown")

      pcall(vim.diagnostic.enable, false, { bufnr = args.buf })
      pcall(function()
        require("gitsigns").detach(args.buf)
      end)

      -- Auto-open ZenMode for a true centered page (equal left/right margins)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          pcall(require("zen-mode").open)
        end
      end)
    end,
  })

  vim.api.nvim_set_hl(0, "Normal",      { bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "NormalNC",   { bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

  -- Heading levels: monochromatic palette — white → gray, bold on H1/H2
  vim.api.nvim_set_hl(0, "RenderMarkdownH1",   { fg = "#FFFFFF", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH2",   { fg = "#DDDDDD", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH3",   { fg = "#C0C0C0" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH4",   { fg = "#AAAAAA" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH5",   { fg = "#888888" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH6",   { fg = "#666666" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#262626" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#242424" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#222222" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#222222" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#222222" })
  vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#222222" })
  -- Link accent: muted purple/periwinkle
  vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = "#8080C8" })

  pcall(require, "core.note_keymaps")
  pcall(require, "plugin.dirvish_notes")
  pcall(require, "plugin.lualine_notes")
  pcall(function()
    require("core.writing_layout").setup()
  end)

  set_terminal_bg("#1e1e1e")
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = reset_terminal_bg,
  })
end

return M
