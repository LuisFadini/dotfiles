#Install Powershell
winget install -e -id Microsoft.PowerShell

#Install Git
winget install -e --id Git.Git
winget install -e --id GitHub.GitHubDesktop

#Install NVM
winget install -e --id CoreyButler.NVMforWindows

#Install Python
winget install -e --id Python.Python.3.10 -v 3.10.8

#Install Discord
winget install -e --id discord.Discord
winget install -e --id discord.Discord.PTB

#Install VS Code
winget install -e --id Microsoft.VisualStudioCode

#Install OperaGx
winget install -e --id OperaGx.OperaGx

#Install Terminal
winget install -e --id Microsoft.WindowsTerminal

#Install Scoop
iwr -useb get.scoop.sh | iex

#Install Curl and NeoVim
scoop install curl neovim

#Install winrar
winget install -e --id RARLab.WinRAR

#Install cosmetics
winget install -e --id Rainmeter.Rainmeter
winget install -e --id rocksdanister.LivelyWallpaper
winget install -e --id 9PF4KZ2VN4W9 --source msstore

#Install gaming things
winget install -e --id Valve.Steam
winget install -e --id EpicGames.EpicGamesLauncher
winget install -e --id Spotify.Spotify
winget install -e --id Logitech.GHUB

#Install terminal theme engine
winget install -e --id JanDeDobbeleer.OhMyPosh -s winget
Install-Module posh-git -Scope CurrentUser -Force
Install-Module Terminal-Icons -Scope CurrentUser -Force

#Install extra terminal features
Install-Module PSReadLine -Scope CurrentUser -Force

#Install Node.js
nvm install 16.14.0
nvm on
nvm use 16.14.0
npm install -g yarn

#Install WSL
wsl --install
wsl --install -d Ubuntu
wsl --set-default Ubuntu
wsl --set-version Ubuntu 2

#Install Docker
winget install -e --id Docker.DockerDesktop