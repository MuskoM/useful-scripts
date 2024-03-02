-- Setting tab as 4 spaces
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.expandtab=true

-- Set relative numbers
vim.o.number=true
vim.o.relativenumber=true

-- Don't wrap files
vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true

-- Search config
vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 7
vim.o.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.o.updatetime = 50

vim.g.mapleader = " "
