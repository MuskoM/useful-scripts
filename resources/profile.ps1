$env:FZF_DEFAULT_OPTS = '--height ~80% --tmux bottom,80% --layout reverse --border --preview "bat --color=always {}"'
Set-Alias -Name ls -Value eza -Option AllScope
Set-Alias -Name cat -Value bat -Option AllScope
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
