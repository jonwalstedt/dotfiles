-- DevMode: keeps LSP servers (incl. their typechecking/diagnostics),
-- null-ls linting (codespell/hadolint/markdownlint/write_good), nvim-cmp,
-- LuaSnip and nvim-ts-autotag completely out of the way until explicitly
-- requested. null-ls's *formatters* (stylua/prettierd/gofumpt/shfmt) stay
-- always-on — see plugin.null-ls.
--
-- Nothing in this file requires any of the gated plugins, so requiring it
-- (from core.commands / plugin.lualine) is essentially free.
--
-- Usage: :DevStart / :DevStop / :DevToggle (see core.commands)

local M = {}

-- Plugins that stay `lazy = true` in core.plugins and are only loaded the
-- first time DevMode is started.
local gated_plugins = {
  "nvim-lspconfig",
  "schemastore.nvim",
  "nvim-ts-autotag",
  "nvim-cmp",
  "LuaSnip",
}

M.enabled = false
local loaded = false

function M.is_enabled()
  return M.enabled
end

-- vim.lsp.enable() itself scans already-open buffers for matches (no need
-- to manually re-fire FileType — doing so risks tripping up unrelated
-- plugins' own FileType handlers for buffers we don't own).

local function stop_managed_clients()
  local lsp = require("lsp")
  local managed = {}
  for _, name in ipairs(lsp.registered_servers) do
    managed[name] = true
  end

  for _, client in ipairs(vim.lsp.get_clients()) do
    if managed[client.name] then
      client:stop()
    end
  end
end

function M.start()
  if M.enabled then
    vim.notify("DevMode already active", vim.log.levels.INFO)
    return
  end

  if not loaded then
    require("lazy").load({ plugins = gated_plugins })
    require("plugin.autotag")
    require("plugin.cmp")
    loaded = true
  end

  M.enabled = true
  require("lsp").setup()
  require("plugin.null-ls").enable_linting()

  vim.notify("DevMode ON — LSP, completion, LuaSnip & linting enabled", vim.log.levels.INFO)
end

function M.stop()
  if not M.enabled then
    vim.notify("DevMode already off", vim.log.levels.INFO)
    return
  end

  M.enabled = false

  require("plugin.null-ls").disable_linting()

  if loaded then
    require("lsp").disable_autostart()
    stop_managed_clients()
  end

  vim.notify("DevMode OFF — LSP, completion & linting stopped", vim.log.levels.WARN)
end

function M.toggle()
  if M.enabled then
    M.stop()
  else
    M.start()
  end
end

return M
