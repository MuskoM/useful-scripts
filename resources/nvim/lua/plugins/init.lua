local plugins = {
	{"nvim-treesitter/nvim-treesitter", build=":TSUpdate"},
	{"nvim-lualine/lualine.nvim", dependencies={"nvim-tree/nvim-web-devicons"}},
	{"nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies={"nvim-lua/plenary.nvim"}},
	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "mypy",
                "debugpy",
                "pyright",
            }
        }
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
        ft = {"python"},
        opts = function ()
            require 'plugins.configs.none-ls'
        end
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

}

require("lazy").setup(plugins)

-- Setup lualine
require("lualine").setup({
	options = {theme="catppuccin"}
})


