:: wsl-run.bat
@echo off
for /f "tokens=3 delims=: " %%I in ('netsh interface IPv4 show addresses "vEthernet (WSL)" ^| findstr /C:"Adresse IP"') do set ip==%%I
set ipAddress=%ip:~1%

echo "Ip address: %ipAddress%"

Powershell.exe wsl "DISPLAY='%ipAddress%':0" nohup %1 < /dev/null
