local null_ls = require('null-ls')
local opts = {
    sources = {
        null_ls.builtins.diagnostics.mypy,
    }
}
return opts
