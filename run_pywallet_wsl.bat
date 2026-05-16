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

if "%~1"=="" (
  echo Starting pywallet in WSL TUI mode...
  wsl bash -lc "set -e; cd \"$REPO_WIN\"; sed -i 's/\r$//' install.sh run_pywallet.sh; if [ ! -d pywallet_build_env ]; then echo 'Virtualenv not found. Running install.sh first...'; chmod +x install.sh; ./install.sh; fi; . pywallet_build_env/bin/activate; python3 pywallet.py --tui"
) else (
  wsl bash -lc "set -e; cd \"$REPO_WIN\"; sed -i 's/\r$//' install.sh run_pywallet.sh; if [ ! -d pywallet_build_env ]; then echo 'Virtualenv not found. Running install.sh first...'; chmod +x install.sh; ./install.sh; fi; . pywallet_build_env/bin/activate; python3 pywallet.py \"$@\"" -- %*
)

set "EXIT_CODE=%ERRORLEVEL%"
echo.
if not "%EXIT_CODE%"=="0" (
  echo pywallet in WSL exited with code %EXIT_CODE%.
)
pause
exit /b %EXIT_CODE%
