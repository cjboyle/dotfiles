# Imports
Import-Module oh-my-posh
Import-Module posh-git
Import-Module PSColor


. "$env:USERPROFILE/.pwsh/prompt.ps1"
. "$env:USERPROFILE/.pwsh/profile.ps1"


# PSColor overrides
$global:PSColor.File.Executable.Color = 'Blue'
