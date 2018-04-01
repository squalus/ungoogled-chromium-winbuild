$version = "2.7.14"
$md5 = "370014d73c3059f610c27365def62058"

$downloadFolder = "$home\Downloads"
$filename = "python-$version.amd64.msi"
$url = "https://www.python.org/ftp/python/$version/$filename"
$installerFile = "$downloadFolder\$filename"

Write-Host "Downloading $url"
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
msiexec /i $installerFile /passive

Write-Host "Updating PATH"
$oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$newPath="$oldPath;C:\Python27"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
