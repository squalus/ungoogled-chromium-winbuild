$ErrorActionPreference = "Stop"
$url = "https://aka.ms/vs/15/release/vs_community.exe"
$downloadFolder = "$home\Downloads"
$vsInstallerFile = "$downloadFolder\vs_community.exe"

Write-Host "Downloading $url"
Invoke-WebRequest -Uri $url -OutFile $vsInstallerFile

Write-Host "Installing $vsInstallerFile"

Start-Process $vsInstallerFile -NoNewWindow -Wait -ArgumentList  "-p","--nocache","--add","Microsoft.VisualStudio.Component.VC.ATLMFC","--add","Microsoft.VisualStudio.Workload.NativeDesktop","--includeRecommended"
