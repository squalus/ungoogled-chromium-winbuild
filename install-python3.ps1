$ErrorActionPreference = "Stop"
$version = "3.6.5"
$md5Hash = "9e96c934f5d16399f860812b4ac7002b"

$downloadFolder = "$home\Downloads"
$filename = "python-$version-amd64.exe"
$zipInstallerFile = "$downloadFolder\$filename"
$url = "https://www.python.org/ftp/python/$version/$filename"

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
