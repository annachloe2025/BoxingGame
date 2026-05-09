@echo off
chcp 65001 >nul
cd /d C:\Users\hoeho\Documents\Claude\BoxingGame

echo.
echo === BoxingGame update ===
echo.

echo [setup] Checking MkDocs + Material ...
python -m pip install --quiet --upgrade mkdocs mkdocs-material pymdown-extensions
if errorlevel 1 goto :err

echo [check] Running mkdocs build --strict ...
python -m mkdocs build --strict --site-dir "%TEMP%\boxinggame_buildcheck" >nul
if errorlevel 1 (
    echo   ERROR: mkdocs build --strict failed.
    pause
    exit /b 1
)
rmdir /s /q "%TEMP%\boxinggame_buildcheck" >nul 2>&1
echo   OK: strict build passed.

set "MSG="
set /p MSG=Commit message (Enter for default):
if "%MSG%"=="" set "MSG=Update docs"

echo [1/3] git add
git add .

echo [2/3] git commit
git commit -m "%MSG%"
if errorlevel 1 echo   (nothing to commit, or commit skipped)

echo [3/3] git push
git push
if errorlevel 1 goto :err

echo.
echo === Done ===
echo Actions: https://github.com/annachloe2025/BoxingGame/actions
echo Site:    https://annachloe2025.github.io/BoxingGame/
echo.
pause
exit /b 0

:err
echo.
echo ERROR. See message above.
pause
exit /b 1
