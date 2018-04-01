cd C:\Users\vagrant
powershell -command "Remove-Item -Recurse -Force ungoogled-chromium"
del /s /q ungoogled-chromium
rmdir /s /q ungoogled-chromium
call "C:\Program Files\7-Zip\7z.exe" x shared\ungoogled-chromium-repo.zip -y
cd ungoogled-chromium
mkdir buildspace\downloads
call py buildkit-launcher.py genbun windows
call py buildkit-launcher.py getsrc --disable-ssl-verification --hide-progress-bar
call py buildkit-launcher.py subdom
call py buildkit-launcher.py genpkg windows
call py buildspace\tree\ungoogled_packaging\scripts\apply_patch_series.py
call buildspace\tree\ungoogled_packaging\build.bat
call ungoogled_packaging\package.bat
