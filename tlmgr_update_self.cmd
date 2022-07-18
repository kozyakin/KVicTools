@echo off
chcp 65001 >nul
echo. 
@echo on
tlmgr.bat update --self --pause
