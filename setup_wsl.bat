@echo off
setlocal

cd /d "%~dp0"

where wsl >nul 2>&1
if errorlevel 1 (
  echo WSL was not found on this system.
  echo Install WSL first, then run this script again.
  pause
  exit /b 1
)

set "REPO_WIN=%CD%"
if defined WSLENV (
  set "WSLENV=REPO_WIN/p:%WSLENV%"
) else (
  set "WSLENV=REPO_WIN/p"
)

echo Setting up pywallet inside WSL...
wsl bash -lc "set -e; cd \"$REPO_WIN\"; sed -i 's/\r$//' install.sh run_pywallet.sh; chmod +x install.sh run_pywallet.sh; ./install.sh"
set "EXIT_CODE=%ERRORLEVEL%"

echo.
if "%EXIT_CODE%"=="0" (
  echo WSL setup completed successfully.
  echo Next step: run run_pywallet_wsl.bat
) else (
  echo WSL setup failed with code %EXIT_CODE%.
)

pause
exit /b %EXIT_CODE%
