require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
  render_modes = true,

  heading = {
    enabled = true,
    sign = false,
    width = "block",
    left_pad = 1,
    right_pad = 4,
    -- Taller top/bottom margin on H1, narrowing down each level
    above = "▄",
    below = "▀",
    icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
  },

  code = {
    enabled = true,
    sign = false,
    style = "full",
    width = "block",
    left_pad = 2,
    right_pad = 4,
    border = "thin",
    language_name = true,
  },

  dash = {
    enabled = true,
    -- Render --- as a full-width horizontal rule
    width = "full",
    icon = "─",
  },

  bullet = {
    enabled = true,
    -- Nested bullet icons like Obsidian
    icons = { "●", "○", "◆", "◇" },
    left_pad = 0,
    right_pad = 1,
  },

  checkbox = {
    enabled = true,
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
    custom = {
      todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
    },
  },

  quote = {
    enabled = true,
    icon = "▋",
    repeat_linebreak = true,
  },

  table = {
    enabled = true,
    style = "full",
    cell = "padded",
  },

  link = {
    enabled = true,
    image = "󰥶 ",
    email = "󰀓 ",
    hyperlink = "󰌹 ",
    wiki = { icon = "󱗖 " },
  },

  html = { enabled = false },
  latex = { enabled = false },

  callout = {
    note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
    tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
    important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
    warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
    caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
  },
})
