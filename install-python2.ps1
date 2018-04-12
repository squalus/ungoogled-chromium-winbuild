$ErrorActionPreference = "Stop"
$version = "2.7.14"
$md5 = "370014d73c3059f610c27365def62058"

$downloadFolder = "$home\Downloads"
$filename = "python-$version.amd64.msi"
$url = "https://www.python.org/ftp/python/$version/$filename"
$installerFile = "$downloadFolder\$filename"

Write-Host "Downloading $url"
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
Invoke-WebRequest -Uri $url -OutFile $installerFile

Write-Host "Checking hash"
$hash = Get-FileHash $installerFile -Algorithm MD5
if ($hash.Hash -eq $md5) {
    Write-Host "Hash matches"
} else {
    Write-Host "Hash mismatch"
    [Environment]::Exit(1)
}

Write-Host "Installing $installerFile"
Start-Process "msiexec" -NoNewWindow -Wait -ArgumentList "/i",$installerFile,"/passive"

Write-Host "Updating PATH"
$oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newPath="$oldPath;C:\Python27"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

$module="pypiwin32==223"
Write-Host "Installing $module"
Start-Process "C:\Python27\Scripts\pip.exe" -NoNewWindow -Wait -ArgumentList  "install","--disable-pip-version-check",$module
