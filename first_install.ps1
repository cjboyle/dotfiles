#Requires -RunAsAdministrator

Set-ExecutionPolicy RemoteSigned -scope CurrentUser -Force

# Install Scoop
Invoke-WebRequest 'https://get.scoop.sh' | Invoke-Expression

# Install Chocolatey
Invoke-WebRequest 'https://chocolatey.org/install.ps1' | Invoke-Expression
choco install -y choco-cleaner

# Install basic utilities
scoop install -g psutils
scoop install -g gcc
scoop install -g git
scoop install -g 7zip
scoop install -g openssh
scoop install -g vim
scoop install -g bat
scoop install -g curl
scoop install -g make
scoop install -g micro

choco install powershell-core -y
