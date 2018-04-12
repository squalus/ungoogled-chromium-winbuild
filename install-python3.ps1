$ErrorActionPreference = "Stop"
$version = "3.6.4"
$md5Hash = "67e1a9bb336a5eca0efcd481c9f262a4"

$downloadFolder = "$home\Downloads"
$filename = "python-$version.exe"
$zipInstallerFile = "$downloadFolder\$filename"
$url = "https://www.python.org/ftp/python/$version/python-$version.exe"

Write-Host "Downloading $url"
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
Invoke-WebRequest -Uri $url -OutFile $zipInstallerFile

Write-Host "Checking hash"
$hash = Get-FileHash $zipInstallerFile -Algorithm MD5
if ($hash.Hash -eq $md5Hash) {
    Write-Host "Hash matches"
} else {
    Write-Host "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Host "Installing $zipInstallerFile"
Start-Process $zipInstallerFile -NoNewWindow -Wait -ArgumentList /quiet,InstallAllUsers=1
