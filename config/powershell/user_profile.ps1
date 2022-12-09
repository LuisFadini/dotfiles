[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Theme
Import-Module posh-git
Import-Module Terminal-Icons
oh-my-posh init pwsh --config C:\dotfiles\config\powershell\luis.omp.json | Invoke-Expression

# Autocomplete
Set-PSReadLineOption -PredictionSource History

# Aliases
Set-Alias ll ls
Set-Alias -Name vim -Value nvim
Set-Alias g git

# Utility functions
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}  
