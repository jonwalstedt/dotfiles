local util = require("lspconfig.util")

return {
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "vue", "svelte",
  },
  root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts", "postcss.config.js", "package.json", ".git"),
}
