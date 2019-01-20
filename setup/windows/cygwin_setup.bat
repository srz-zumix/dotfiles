set PACKAGES=make,git,wget,chere,automake,zip,curl,libcurl-devel,openssh,dos2unix,cmake
set PACKAGES=%PACKAGES%,gcc,gcc-g++,clang
set PACKAGES=%PACKAGES%,python,ruby,perl
set SITE=http://ftp.iij.ad.jp/pub/cygwin/

if "%~1" == "x64" (
	call :x64
) else (
	call :x86
)

goto install

:x86
set SETUP=setup-x86
set ROOT=C:\cygwin
set LOCALPACKAGE=%~dp0\x86
goto :EOF

:x64
set SETUP=setup-x86_64
set ROOT=C:\cygwin64
set LOCALPACKAGE=%~dp0\x86_64
goto :EOF

:install
rem %SETUP% download
@powershell -NoProfile -ExecutionPolicy Bypass -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.cygwin.com/%SETUP%.exe', '%SETUP%.exe')"

%SETUP%.exe ^
  --root %ROOT% ^
  --site %SITE% ^
  --local-package-dir %LOCALPACKAGE% ^
  --packages %PACKAGES% ^
  --quiet-mode
if errorlevel 1 pause
