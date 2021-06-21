@echo off
chcp 65001 >nul
echo.
echo Настоящий batch-файл предназначен для восстановления в   
echo переменной PATH пути к директории ..\bin\win32 системы TeX Live
echo. 
net session >nul 2>&1
if %errorLevel% == 0 goto work 
echo Данный файл должен запускаться с правами администратора,
echo однако в настоящий момент он запущен с правами обычного 
echo пользователя!
echo.
echo. 
echo Перезапустите данный batch-файл с ПРАВАМИ АДМИНИСТРАТОРА!
echo. 
pause
exit

:work 
echo. 
echo При необходимости измените путь в команде
echo C:\texlive\2021\bin\win32\tlmgr.bat
echo в данном batch-файле
echo. 
pause 
@echo on
cmd.exe /C C:\texlive\2021\bin\win32\tlmgr.bat path add
@echo off
pause