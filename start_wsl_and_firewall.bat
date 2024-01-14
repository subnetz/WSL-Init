:: Check for admin rights
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)
cd /d %1

:: Now we have admin rights
:: check if WSL is running, start if it's not
QPROCESS "wsl.exe"
if %ERRORLEVEL% EQU 0 goto wslrunning

SET wslvbs=%temp%\runwsl.vbs
echo %wslvbs%
echo set ws=wscript.CreateObject("wscript.shell") > %wslvbs%
echo ws.run "wsl -u root", 0 >> %wslvbs%
WScript /nologo %wslvbs%
:wslrunning

:: proxy forward port 22
set PORT=22
netsh advfirewall firewall add rule name="OpenSSH Server (sshd) for WSL" protocol=TCP dir=in localport=%PORT% action=allow enable=yes
netsh interface portproxy delete v4tov4 listenport=%PORT% listenaddress=0.0.0.0 protocol=tcp
for /f %%i in ('wsl hostname -I') do set IP=%%i
netsh interface portproxy add v4tov4 listenport=%PORT% listenaddress=0.0.0.0 connectport=%PORT% connectaddress=%IP%
