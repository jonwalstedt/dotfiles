-- NOTE: `filetypes` is not a real nvim-ts-autotag option anymore (that was
-- the pre-1.0 API) — filetype coverage now comes from the plugin's built-in
-- TagConfigs/aliases and isn't user-configurable here. Only `opts` (and
-- `aliases`/`per_filetype`) are read by the current setup().
require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
})
