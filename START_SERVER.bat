@echo off
REM UNIK AudioFlux Engine - Quick Start Batch Script

setlocal enabledelayedexpansion

echo.
echo ============================================================
echo UNIK AudioFlux Engine - Starting Server
echo ============================================================
echo.

REM Check if Node.js is available
where node >nul 2>nul
if %errorlevel% equ 0 (
    echo Found Node.js installed
    echo Starting server with Node.js...
    echo.
    cd /d "%~dp0"
    node server.js
    exit /b
)

REM Check if Python is available
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo Found Python installed
    echo Starting server with Python...
    echo.
    cd /d "%~dp0"
    python server.py
    exit /b
)

REM Fallback to Python 3
where python3 >nul 2>nul
if %errorlevel% equ 0 (
    echo Found Python 3 installed
    echo Starting server with Python 3...
    echo.
    cd /d "%~dp0"
    python3 server.py
    exit /b
)

REM No compatible runtime found
echo.
echo ERROR: No compatible runtime found!
echo.
echo You need either:
echo 1. Node.js (https://nodejs.org/) - Recommended
echo 2. Python 3 (https://www.python.org/)
echo.
echo After installing one of these, run this script again.
echo.
pause
exit /b 1
