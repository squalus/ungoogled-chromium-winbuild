$ErrorActionPreference = "Stop"
$url = "https://go.microsoft.com/fwlink/p/?LinkId=845298"
$sha256 = '06661d9dcf9147bf3c4aa0b4d3adf74bb099b522f46a674b80cceba7b5361fcc'
$downloadFolder = "$home\Downloads"
$installerFile = "$downloadFolder\winsdk.exe"

Write-Host "Downloading $url"
Invoke-WebRequest -Uri $url -OutFile $installerFile

Write-Host "Checking hash"
$hash = Get-FileHash $installerFile -Algorithm SHA256
if ($hash.Hash -eq $sha256) {
    Write-Host "Hash matches"
} else {
    Write-Host "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Host "Installing $installerFile"
Start-Process $installerFile -NoNewWindow -Wait -ArgumentList '/ceip','off','/features','OptionId.WindowsDesktopDebuggers','OptionId.DesktopCPPx86','OptionId.DesktopCPPx64','/norestart','/q'

Remove-Item $installerFile
