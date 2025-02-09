local nmap = U.keymap.nmap

require('codecompanion').setup {
  opts = {
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      --NOTE: Change the adapter as required
      chat = { adapter = 'openai' },
      inline = { adapter = 'copilot' },
    },
    opts = {
      log_level = 'DEBUG',
    },
  },
  display = {
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = 'vertical', -- vertical|horizontal split for default provider
        opts = {
          'internal',
          'filler',
          'closeoff',
          'algorithm:patience',
          'followwrap',
          'linematch:120',
        },
        provider = 'default', -- default|mini_diff
      },
    },
    action_palette = {
      width = 95,
      height = 10,
      prompt = 'Prompt ', -- Prompt used for interactive LLM calls
      provider = 'default', -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
  },
}

nmap('<leader>ai', ':CodeCompanionAction<CR>')
nmap('<leader>aa', ':CodeCompanionChat Toggle<CR>')
nmap('<leader>ii', ':CodeCompanion')
