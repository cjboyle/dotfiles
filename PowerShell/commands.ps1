# Aliases and Functions
# May override built-in definitions


# execution timer alias
Set-Alias time Measure-Command


# get the executable or alias definition for the given command
function Which-Command {
    param([string]$Name)
    (Get-Command $Name -ErrorAction SilentlyContinue).Definition
}
Set-Alias which Which-Command


# override 'cd' to add dash as a valid argument to go to old working directory (similar to Pop-Location)
if (Test-Path Alias:\cd) { Remove-Item Alias:\cd -Force }
if (! $Global:OLDPWD) { $Global:OLDPWD = $null }
function Set-LocationReversible {
    if ($args[0] -eq '-') { $nwd = $Global:OLDPWD }
    elseif ($args[0] -eq '') { return # don't update old }
    else { $nwd = $args[0]; }
    
    $Global:OLDPWD = Get-Location
    if ($nwd) {
        Set-Location $nwd
        Set-Title "$(Get-ShorterPath)"
    }
}
Set-Alias cd Set-LocationReversible


# helper to 'cd' to a location, creating it if it does not exist
function Set-NewLocation {
    $path = $args[0]
    if (!(Test-Path $path)) {
        mkdir $path
    }
    cd $path
}
Set-Alias mkcd Set-NewLocation


# hashing helpers
function Get-MD5Hash { Get-FileHash -Algorithm MD5 $args }
function Get-SHA1Hash { Get-FileHash -Algorithm SHA1 $args }
function Get-SHA256Hash { Get-FileHash -Algorithm SHA256 $args }
Set-Alias md5 Get-MD5Hash
Set-Alias sha1 Get-SHA1Hash
Set-Alias sha256 Get-SHA256Hash


# for building concise prompt components and window titles
function Get-ShorterPath {
    param(
        [Parameter(Mandatory = $false)]
        [System.Management.Automation.PathInfo]$Path = (Get-Location),
        [Parameter(Mandatory = $false)]
        [int]$MaxLength = 40
    )
    $sp = ($Path).Path
    if ($sp.Length -gt $MaxLength) {
        while ($sp.Length -gt $MaxLength) {
            $splice = $sp.IndexOf('\') + 1
            if ($splice -lt 0) {
                break
            }
            $sp = $sp.Substring($splice)
        }
        $sp = "...\" + $sp
    }
    return $sp
}


# set the window title
function Set-Title ([string] $Text) {
    $Host.UI.RawUI.WindowTitle = $Text
}


# Clear old versions of the .NET Core SDK
function Remove-NetCoreSDK {
    $app = Get-WmiObject -Class Win32_Product | Where-Object {
        $_.Name -match "Microsoft .NET Core SDK"
    }
    Write-Host $app.Name
    Write-Host $app.IdentifyingNumber
    Push-Location $env:SystemRoot\System32
    $app.IdentifyingNumber | ForEach-Object {
        Start-Process msiexec -Wait -ArgumentList "/x $_"
    }
    Pop-Location
}


# git helpers
Set-Alias g git
Set-Alias gs "git status"


# use sudo.cmd over sudo.ps1 as it works better on the new Windows Terminal for whatever reason
Set-Alias sudo sudo.cmd

