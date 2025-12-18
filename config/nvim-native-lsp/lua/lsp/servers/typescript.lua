-- Organize imports command
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

-- Shared filetypes
local typescriptFileTypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

-- vtsls (preferred)
local vtsls = {
  filetypes = typescriptFileTypes,
  root_markers = {
    "tsconfig.json",
    "tsconfig.base.json",
    "package.json",
    ".git"
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize TS Imports",
    },
  },
  settings = {
    complete_function_calls = true,
    vtsls = {},
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}

return {
  __multi = true,
  tsserver = {
    enabled = false,
    filetypes = typescriptFileTypes,
    single_file_support = false,
  },
  ts_ls = {
    enabled = false,
    filetypes = typescriptFileTypes,
  },
  vtsls = vtsls,
}
