@echo off
chcp 1251 >nul
echo.
net session >nul 2>&1
if %errorLevel% == 0 goto work 
echo ��� ������� ���������� ������� TeX Live ���� ����
echo ������ ���� ������� � ������� ��������������!
echo. 
pause
exit

:work
echo. 
echo ��� ������������� �������� ���� � �������
echo C:\texlive\2020\bin\win32\tlmgr.bat
echo � ������ batch-�����
echo. 
pause 
@echo on
cmd.exe /C C:\texlive\2020\bin\win32\tlmgr.bat update --self --all --pause
@echo off