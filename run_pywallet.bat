@echo off
setlocal

REM Windows launcher for pywallet TUI/CLI
cd /d "%~dp0"

if exist "pywallet_build_env\Scripts\python.exe" (
  set "PYW_PY=pywallet_build_env\Scripts\python.exe"
) else (
  set "PYW_PY=python"
)

set "PYTHONIOENCODING=utf-8"
chcp 65001 >nul 2>&1

if "%~1"=="" (
  echo Starting pywallet in TUI mode...
  "%PYW_PY%" pywallet.py --tui
) else (
  "%PYW_PY%" pywallet.py %*
)

set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
  echo.
  echo pywallet exited with code %EXIT_CODE%.
  echo If Python is not installed in Windows, use WSL launchers:
  echo   setup_wsl.bat
  echo   run_pywallet_wsl.bat
  echo.
  pause
)

endlocal
