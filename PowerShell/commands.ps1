# Aliases and Functions
# May override built-in definitions


Set-Alias time Measure-Command


function which {
    param([string]$Name)
    (Get-Command $Name -ErrorAction SilentlyContinue).Definition
}


### Override 'cd' to add dash as an argument to go to old working directory (similar to Pop-Location)
if (Test-Path Alias:\cd) { Remove-Item Alias:\cd -Force }
if (! $Global:OLDPWD) { $Global:OLDPWD = $null }
function cd {
    if ($args[0] -eq '-') { $nwd = $Global:OLDPWD }
    elseif ($args[0] -eq '') { return # don't update old }
    else { $nwd = $args[0]; }
    
    $Global:OLDPWD = Get-Location
    if ($nwd) {
        Set-Location $nwd
        Set-Title "$(Get-ShorterPath)"
    }
}

function mkcd {
    $path = $args[0]
    if (!(Test-Path $path)) {
        mkdir $path
    }
    cd $path
}


### Hashing functions
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }


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


### Set the window title
function Set-Title ([string] $Text) {
    $Host.UI.RawUI.WindowTitle = $Text
}


### Clear old versions of the .NET Core SDK
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


# use sudo.cmd over sudo.ps1 as it works better on Win Terminal for some reason
Set-Alias sudo sudo.cmd

