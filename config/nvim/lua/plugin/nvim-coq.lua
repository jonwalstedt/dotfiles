vim.g.coq_settings = {
  auto_start = 'shut-up',
  match = { max_results = 2000 },
  keymap = { recommended = true, jump_to_mark = '<C-n>' },
  clients = { tmux = { enabled = false } }
}
