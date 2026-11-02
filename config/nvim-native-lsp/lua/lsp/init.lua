local M = {}

-- List of servers managed by this module (also used by core.dev_mode to
-- know what to enable/disable when toggling DevMode).
M.servers = {
  "gopls",
  "html",
  "lua_ls",
  "pyright",
  "typescript",
  "jsonls",
  "stylelint",
  "cssls",
  "tailwindcss",
}

local handlers_initialized = false

-- Actual lsp client names that end up registered/enabled via vim.lsp.enable
-- (differs from M.servers for multi-server entries, e.g. "typescript" -> "vtsls").
M.registered_servers = {}

-- Registers configs and turns on autostart for every server in M.servers.
-- Safe to call multiple times (e.g. every time DevMode is (re-)started):
-- vim.lsp.config/vim.lsp.enable are idempotent.
function M.setup()
  if not handlers_initialized then
    require("lsp.handlers").setup()
    handlers_initialized = true
  end

  local on_attach = require("lsp.on_attach")
  local lsp_capabilities = require("lsp.capabilities").setup()

  -- Helper to extend config safely
  local function extend_config(cfg)
    if type(cfg) ~= "table" then
      return cfg
    end
    local new_cfg = vim.tbl_deep_extend("force", {}, cfg)
    new_cfg.on_attach = on_attach
    new_cfg.capabilities = lsp_capabilities
    return new_cfg
  end

  local function mark_registered(name)
    if not vim.tbl_contains(M.registered_servers, name) then
      table.insert(M.registered_servers, name)
    end
  end

  for _, name in ipairs(M.servers) do
    local ok, server_cfgs = pcall(require, "lsp.servers." .. name)

    if not ok then
      local cfg = extend_config({})
      vim.lsp.config(name, cfg)
      vim.lsp.enable(name)
      mark_registered(name)
    elseif type(server_cfgs) == "table" then
      -- Detect multi-server by a special marker
      if server_cfgs.__multi then
        for server, cfg in pairs(server_cfgs) do
          if server ~= "__multi" and type(cfg) == "table" and cfg.enabled ~= false then
            local final_cfg = extend_config(cfg)
            vim.lsp.config(server, final_cfg)
            vim.lsp.enable(server)
            mark_registered(server)
          end
        end
      else
        -- single server config
        local cfg = extend_config(server_cfgs)
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
        mark_registered(name)
      end
    else
      vim.notify("Invalid config for " .. name .. ": got " .. type(server_cfgs), vim.log.levels.ERROR)
    end
  end
end

-- Disables autostart for every server that was registered via M.setup()
-- (does not stop already running clients — core.dev_mode handles that).
function M.disable_autostart()
  for _, name in ipairs(M.registered_servers) do
    vim.lsp.enable(name, false)
  end
end

return M
