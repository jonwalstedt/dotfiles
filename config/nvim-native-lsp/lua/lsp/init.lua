local handlers = require("lsp.handlers")
local capabilities = require("lsp.capabilities")

handlers.setup()

local on_attach = require("lsp.on_attach")

-- list of servers
local servers = {
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

-- Helper to extend config safely
local function extend_config(cfg)
  if type(cfg) ~= "table" then
    return cfg
  end
  local new_cfg = vim.tbl_deep_extend("force", {}, cfg)
  new_cfg.on_attach = on_attach
  new_cfg.capabilities = capabilities.setup()
  return new_cfg
end

for _, name in ipairs(servers) do
  local ok, server_cfgs = pcall(require, "lsp.servers." .. name)

  if not ok then
    local cfg = extend_config({})
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
  elseif type(server_cfgs) == "table" then
    -- Detect multi-server by a special marker
    if server_cfgs.__multi then
      for server, cfg in pairs(server_cfgs) do
        if server ~= "__multi" and type(cfg) == "table" and cfg.enabled ~= false then
          local final_cfg = extend_config(cfg)
          vim.lsp.config(server, final_cfg)
          vim.lsp.enable(server)
        end
      end
    else
      -- single server config
      local cfg = extend_config(server_cfgs)
      vim.lsp.config(name, cfg)
      vim.lsp.enable(name)
    end
  else
    vim.notify("Invalid config for " .. name .. ": got " .. type(server_cfgs), vim.log.levels.ERROR)
  end
end
