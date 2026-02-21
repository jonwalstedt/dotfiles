local U = {}

local function start_hidden_terminal(cmd, name)
  -- create fresh split to safely attach terminal
  vim.cmd("botright split")
  vim.cmd("terminal " .. cmd)

  local buf = vim.api.nvim_get_current_buf()

  -- name buffer
  vim.api.nvim_buf_set_name(buf, "file:" .. name)

  -- ensure it survives window closing
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })

  -- close window, keep job running
  vim.cmd("close")

  return buf
end

local function start_visible_terminal(cmd, name)
  vim.cmd("terminal " .. cmd)

  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_name(buf, "file:" .. name)
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })

  return buf
end

--- Deterministic 2-column layout
--- Left: explorer
--- Right: visible terminal
function U.start(steps)
  local visible_term = nil
  local explorer_cmd = nil

  -- Phase 1: Start all jobs
  for _, step in ipairs(steps or {}) do
    local kind = step[1]

    if kind == "terminal" then
      local cmd = step[2]
      local name = step[3]
      local opts = step[4] or {}

      if opts.hide then
        start_hidden_terminal(cmd, name)
      else
        -- defer visible terminal until after layout reset
        visible_term = { cmd = cmd, name = name }
      end
    else
      -- treat as explorer command
      explorer_cmd = kind
    end
  end

  -- Phase 2: Hard reset layout
  vim.cmd("only")
  vim.cmd("vsplit")

  -- Left window → explorer
  vim.cmd("wincmd h")
  if explorer_cmd then
    vim.cmd(explorer_cmd)
  end

  -- Right window → visible terminal
  vim.cmd("wincmd l")
  if visible_term then
    start_visible_terminal(visible_term.cmd, visible_term.name)
  end
end

local function kibana_steps()
  return {
    { "terminal", "yarn es snapshot --license trial", "elasticsearch", { hide = true } },
    { "terminal", "yarn start --no-base-path",        "kibana",        { hide = true } },
    { "terminal", "agent .",                          "assistant" },
    { "Dirvish" },
  }
end

function U.setup()
  vim.api.nvim_create_user_command("Kibana", function()
    U.start(kibana_steps())
  end, { desc = "Start Kibana dev env (ES+Kibana hidden, agent visible, Dirvish left)" })
end

return U
