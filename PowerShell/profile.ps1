. "$env:USERPROFILE/.pwsh/commands.ps1"

# Add OneDrive shortcuts
if (Test-Path HKCU:\Software\Microsoft\OneDrive) {
    $onedrive = Get-ItemProperty -Path HKCU:\Software\Microsoft\OneDrive
    if (Test-Path $onedrive.UserFolder) {
        #New-PSDrive -Name OneDrive -PSProvider FileSystem -Root $onedrive.UserFolder -Description "OneDrive"
        #function OneDrive: { Set-Location OneDrive: }
        $ONEDRIVE = $onedrive.UserFolder
    }
}

# Set the initial window title
Set-Title "$(Get-ShorterPath)"
