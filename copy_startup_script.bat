:: Check privileges
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)
cd /d %1

:: Actual work
copy ".\start_wsl_and_firewall.bat" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\" /Y