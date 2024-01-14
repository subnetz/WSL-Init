:: check for admin rights
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)
cd /d %1

:: now we have admin rights
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "".\start_ssh_agent_service.ps1""' -Verb RunAs}"
exit