-- Setup telescope
local telescope_builtin = require("telescope.builtin")

vim.keymap.set('n','<leader>ff', telescope_builtin.find_files, {desc = '[F]ind [F]iles'})
vim.keymap.set('n','<leader>fg', telescope_builtin.live_grep, {desc = '[F]ind using [G]rep'})
vim.keymap.set('n','<leader>fr', telescope_builtin.git_files, {desc = '[F]ind in [R]epository'})
vim.keymap.set('n','<leader>fb', telescope_builtin.buffers, {desc = '[F]ind [B]uffers'})
vim.keymap.set('n','<leader>fh', telescope_builtin.help_tags, {desc = '[F]ind [H]elp'})
vim.keymap.set('n','<leader>f.', telescope_builtin.oldfiles, {desc = '[F]ind Recent Files'})
vim.keymap.set('n','<leader>fd', telescope_builtin.diagnostics, {desc = '[F]ind [D]iagnostics'})
