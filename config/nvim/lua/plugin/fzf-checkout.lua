-- fzf-checkout.vim
--  https://github.com/stsewd/fzf-checkout.vim
vim.g.fzf_command_prefix = 'Fzf'
vim.g.fzf_branch_actions = {
  diff = {
    prompt = 'Diff> ',
    execute = 'Git diff {branch}',
    multiple = false,
    keymap = 'ctrl-f',
    required = {'branch'},
    confirm = false,
  }
}
