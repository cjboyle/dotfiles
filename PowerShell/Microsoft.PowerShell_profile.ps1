# Imports
Import-Module oh-my-posh
Import-Module posh-git
Import-Module PSColor


#Set-Theme to something in ./PoshThemes/
. "$env:USERPROFILE/Documents/PowerShell/profile.ps1"


# PSColor overrides
$global:PSColor.File.Executable.Color = 'Blue'
