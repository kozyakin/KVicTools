@echo off
chcp 65001 >nul
echo.
@echo on
tlmgr update --all --self --pause
