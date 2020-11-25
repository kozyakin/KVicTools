@echo off
chcp 1251 >nul
echo. 
net session >nul 2>&1
if %errorLevel% == 0 goto work 
echo Для обновления программы tlmgr этот файл
echo должен быть запущен с правами администратора!
echo. 
pause
exit

:work
echo. 
echo. 
echo При необходимости измените путь в команде
echo C:\texlive\2020\bin\win32\tlmgr.bat
echo в данном batch файле
echo. 
pause 
@echo on
cmd.exe /C C:\texlive\2020\bin\win32\tlmgr.bat update --self --pause
@echo off