@echo off
chcp 1251 >nul
echo.
echo ��������� batch-���� ������������ ��� �������������� �   
echo ���������� PATH ���� � ���������� ..\bin\win32 ������� TeX Live
echo. 
net session >nul 2>&1
if %errorLevel% == 0 goto work 
echo ������ ���� ������ ����������� � ������� ��������������,
echo ������ � ��������� ������ �� ������� � ������� �������� 
echo ������������!
echo.
echo. 
echo ������������� ������ batch-���� � ������� ��������������!
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
cmd.exe /C C:\texlive\2020\bin\win32\tlmgr.bat path add
@echo off
pause