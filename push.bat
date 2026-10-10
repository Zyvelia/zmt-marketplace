@echo off
cd /d "%~dp0"

git add -A

for /f "tokens=*" %%i in ('git status --porcelain') do set CHANGES=%%i
if not defined CHANGES (
    echo Nothing to commit.
    pause
    exit /b 0
)

set /p MSG="Commit message (leave blank for auto): "
if "%MSG%"=="" (
    for /f "tokens=*" %%d in ('powershell -command "Get-Date -Format \"yyyy-MM-dd HH:mm\""') do set MSG=Auto-commit %%d
)

git commit -m "%MSG%"
git push

echo.
echo Done.
pause
