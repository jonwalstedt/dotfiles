require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
  render_modes = true,
  heading = {
    enabled = true,
    sign = false,
  },
  code = {
    sign = false,
    width = "block",
    right_pad = 1,
  },
  bullet = {
    enabled = true,
  },
  checkbox = {
    enabled = true,
  },
  quote = {
    enabled = true,
  },
})
