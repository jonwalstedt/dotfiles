local util = require("lspconfig.util")

return {
  filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
  root_dir = util.root_pattern(".stylelintrc", ".stylelintrc.json", "package.json"),
}
