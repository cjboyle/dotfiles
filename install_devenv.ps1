#Requires -RunAsAdministrator

# VS Code
choco install -y vscode
vscode --install-extension shan.code-settings-sync

# .NET Core, ASP.NET Core
choco install -y dotnetcore aspnetcore-runtimepackagestore dotnetcore-sdk dotnetcore-windowshosting

# OpenJDK
choco install -y openjdk

# Python 3
scoop install -g python

# Node JS
scoop install -g nodejs

# Other
scoop install go
scoop install rust
scoop install php

# Databases
scoop install postresql
scoop install sqlite
scoop install mongodb

# VS 2019 Community
choco install -y visualstudio2019community visualstudio2019-workloads-netcoretools visualstudio2019-workloads-netweb
