@echo off
cd /d "%USERPROFILE%\Desktop\GitHub\video"

git add .
git commit -m "update"
git push

pause