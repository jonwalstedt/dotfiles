require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "ayu",
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
