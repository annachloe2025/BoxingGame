@echo off
chcp 65001 >nul
cd /d C:\Users\hoeho\Documents\Claude\BoxingGame

echo.
echo === BoxingGame init ===
echo.

REM if .git exists and looks healthy, skip init
if not exist .git\HEAD (
  echo [1/5] git init
  git init -b main || goto :err
) else (
  echo [1/5] .git already exists - skip init
)

echo [2/5] add remote
git remote add origin https://github.com/annachloe2025/BoxingGame.git 2>nul
git remote set-url origin https://github.com/annachloe2025/BoxingGame.git

echo [3/5] stage files
git add .

echo [4/5] commit
git commit -m "Initial commit: design docs (Phase 0)"

echo [5/5] push
git branch -M main
git push -u origin main || goto :err

echo.
echo === Done ===
echo Site: https://annachloe2025.github.io/BoxingGame/
echo Actions: https://github.com/annachloe2025/BoxingGame/actions
echo Enable Pages: Settings -^> Pages -^> Source = "GitHub Actions"
echo.
pause
exit /b 0

:err
echo.
echo ERROR. See message above.
pause
exit /b 1
