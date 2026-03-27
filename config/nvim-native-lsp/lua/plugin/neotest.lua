require('neotest').setup({
  adapters = {
    require('neotest-jest')({}),
    require('neotest-go')({}),
    require('neotest-python')({}),
  },
  output = { open_on_run = false },
  summary = { animated = false },
})
