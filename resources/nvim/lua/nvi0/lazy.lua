-- Setup lazy.vim
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "folke/which-key.nvim",
        event = 'VeryLazy',
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = function()
            require('trouble').setup({})
            vim.keymap.set('n','<leader>dl', vim.cmd.Trouble)
        end
    },
	{"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
	{"nvim-lualine/lualine.nvim", dependencies={"nvim-tree/nvim-web-devicons"}},
	{"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies={"nvim-lua/plenary.nvim"}},
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "pylint",
                "black",
                "isort",
                "mypy",
                "debugpy",
                "pyright",
            }
        },
        cmd = function ()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
	"williamboman/mason-lspconfig.nvim",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {

            -- LSP Support
            "neovim/nvim-lspconfig",

            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets"
        }
    },
    -- Luasnip + nvim-cmp
    -- nvim-autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "nvimtools/none-ls.nvim",
    },
    {
        "mfussenegger/nvim-dap",
        config = function (_, opts)
            vim.keymap.set('n','<leader>db', '<cmd> DapToggleBreakpoint <CR>')
            vim.keymap.set('n','<leader>dc', function ()
                require('dap').continue()
            end)
            vim.keymap.set('n','<leader>ds', '<cmd> DapStepOver <CR>')
            vim.keymap.set('n','<leader>di', '<cmd> DapStepInto <CR>')
            vim.keymap.set('n','<leader>do', '<cmd> DapStepOut <CR>')
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui"
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            vim.keymap.set('n','<leader>dtm',function ()
                require('dap-python').test_method()
            end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function ()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function ()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end
        end
    },
    {'mbbill/undotree'},
    {
        "folke/which-key.nvim",
        event = 'VimEnter',
        config = function ()
            require('which-key').setup{}
            require('which-key').register {
                ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore'}
            }
        end
    },
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = {'nvim-lua/plenary.nvim'},
        opts = { signs = false },
    },
}

local opts = {}


require('lazy').setup(plugins, opts)

