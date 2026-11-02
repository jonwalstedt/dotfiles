-- Voice Supervisor managed focus bridge
local ok, supervisor = pcall(dofile, "/Users/jonwalstedt/repos/jonwalstedt/voice-driven-orchestrator/integrations/neovim/lua/voice_supervisor/init.lua")
if ok then supervisor.setup() else vim.notify('Voice Supervisor focus bridge unavailable; reinstall the integration', vim.log.levels.WARN) end
