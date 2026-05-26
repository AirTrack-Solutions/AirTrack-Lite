@echo off
echo.
echo   AirTrack Lite 1.0.0 "Wilbur" - Starting...
echo.

cd /d "%~dp0"
docker compose up -d

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo   [ERROR] Failed to start AirTrack. Is Docker Desktop running?
    echo.
    pause
    exit /b 1
)

echo.
echo   AirTrack Lite is running.
echo   Opening browser...
echo.

timeout /t 3 /nobreak >nul
start http://localhost:5000
