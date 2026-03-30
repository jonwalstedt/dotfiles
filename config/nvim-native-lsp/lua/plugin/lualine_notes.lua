local bg = "#1e1e1e"
local fg = "#1e1e1e"

local notes_theme = {
  normal  = { a = { bg = "#5294e2", fg = fg, gui = "bold" }, b = { bg = bg }, c = { bg = bg } },
  insert  = { a = { bg = "#87c96a", fg = fg, gui = "bold" }, b = { bg = bg }, c = { bg = bg } },
  visual  = { a = { bg = "#e5c07b", fg = fg, gui = "bold" }, b = { bg = bg }, c = { bg = bg } },
  replace = { a = { bg = "#e06c75", fg = fg, gui = "bold" }, b = { bg = bg }, c = { bg = bg } },
  command = { a = { bg = "#c678dd", fg = fg, gui = "bold" }, b = { bg = bg }, c = { bg = bg } },
  inactive = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
}

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = notes_theme,
    component_separators = "",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_x = { "filetype" },
    lualine_y = {},
    lualine_z = { "location" },
  },
})
