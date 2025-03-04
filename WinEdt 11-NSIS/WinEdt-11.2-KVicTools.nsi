;WinEdt-11.2-KVicTools for WinEdt NSIS Install Script
;--------------------------------
;Header Files

Unicode True

!include "x64.nsh"
!include "MUI2.nsh"
!include "FileFunc.nsh"

;--------------------------------
;Constants

!define MUI_PRODUCT "WinEdt-${MUI_VERSION}-KVicTools"
!define MUI_VERSION "11.2"
!define MUI_BUILD "20240413"
!define MUI_COMPANY "WinEdt KVicTools"
!define WINEDT_PRODUCT "WinEdt 11"
!define /date YEAR "%Y"
!define /date BUILD_DATE "%Y%m%d"

;--------------------------------
;Build number update

!define BUILD_FILE "build" 
!include /NonFatal "${BUILD_FILE}"
!ifndef BUILD_NUM
        !define BUILD_NUM 0 ;if we have no previous number
        !else
        !delfile "${BUILD_FILE}"
        !endif
!define /math BUILD_NUM_NEXT ${BUILD_NUM} + 1
!appendfile "${BUILD_FILE}" "!define BUILD_NUM ${BUILD_NUM_NEXT}"

;--------------------------------
;Variables

Var AccountType
Var OldInstallLocation
Var OldInstallVersion

;--------------------------------
;Installer Attributes

VIProductVersion "${MUI_VERSION}.${YEAR}.${BUILD_NUM}"
VIAddVersionKey ProductName "${MUI_PRODUCT}"
VIAddVersionKey CompanyName "${MUI_COMPANY}"
VIAddVersionKey LegalCopyright "Copyright (C) 2010-2024 by Victor Kozyakin"
VIAddVersionKey FileDescription "${MUI_PRODUCT} Setup"
VIAddVersionKey FileVersion "${MUI_VERSION}.${YEAR}.${BUILD_NUM}"
VIAddVersionKey ProductVersion "${MUI_VERSION} Build: ${BUILD_DATE}"

;--------------------------------
;Configuration

SetCompressor /SOLID LZMA

Name "${MUI_PRODUCT}"
OutFile "setup-${MUI_PRODUCT}.exe"

ShowInstDetails nevershow
ShowUninstDetails nevershow

RequestExecutionLevel highest
; Images are poorly rendered on high dpi ...
ManifestDPIAware true

;--------------------------------
;Interface

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_ICON "install.ico"
!define MUI_UNICON "install.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "WinEdt.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "side.bmp"

BrandingText "${MUI_COMPANY}"

;--------------------------------
;Installer Pages

!define MUI_WELCOMEPAGE_TITLE_3LINES
!insertmacro MUI_PAGE_WELCOME

!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "License.txt"

!define MUI_PAGE_HEADER_TEXT "Информация"
!define MUI_PAGE_HEADER_SUBTEXT "Пожалуйста, прежде чем продолжить прочитайте следующую информацию."
!define MUI_LICENSEPAGE_TEXT_TOP "Нажмите PageDown, чтобы увидеть продолжение информации."
!define MUI_LICENSEPAGE_TEXT_BOTTOM "Когда будете готовы, нажмите кнопку $\"Далее$\" для продолжения."
!define MUI_LICENSEPAGE_BUTTON "Далее >"
!insertmacro MUI_PAGE_LICENSE "Readme.txt"

!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_FINISHPAGE_RUN "$OldInstallLocation\WinEdt.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS "-V -E=%b\WinEdt.dnt"
!define MUI_FINISHPAGE_RUN_TEXT "Запуск WinEdt"
!insertmacro MUI_PAGE_FINISH

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

ShowInstDetails show

Section "Full"
;	MessageBox MB_ICONEXCLAMATION|MB_OK "$INSTDIR$\n$OldInstallLocation$\n$UserProfileFolder"

;Copy Files
  SetOverwrite on
  SetOutPath "$INSTDIR"
;  SetOutPath "c:\temp\2"
  File /r "UserData\*.*"

SectionEnd

;--------------------------------
;Installer Functions

;--------------------------------
;Init Functions

Function .onInit

  !ifndef WINEDT_32
        ${IfNot} ${RunningX64}
              MessageBox MB_OK "64-битный WinEdt не может быть установлен на 32-битную платформу." /SD IDOK
              Abort
        ${EndIf}
        SetRegView 64
  !endif

  StrCpy $AccountType "User"
  SetShellVarContext current

  ;Default Installation Folder

  ReadRegStr $OldInstallLocation HKLM64 "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "InstallLocation"

  ;Check whether original WinEdt installed

  ${If} $OldInstallLocation != ""
        StrCpy $INSTDIR "$APPDATA\${MUI_COMPANY}\${WINEDT_PRODUCT}"
  ${Else}
        MessageBox MB_ICONEXCLAMATION|MB_OK "Установка WinEdt ${MUI_VERSION} KVicTools невозможна!$\n$\n\
        Информация об оригинальной (английской) версии WinEdt в регистре отсутствует или испорчена!$\n$\n\
        Переустановите или установите заново WinEdt ${MUI_VERSION} в режиме 'Admin installation' после чего возобновите установку WinEdt KVicTools." /SD IDOK
        Abort
  ${EndIf}

  ;Check original WinEdt version

 ReadRegStr $OldInstallVersion HKLM64 "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "DisplayVersion" 

 ${If} $OldInstallVersion != ${MUI_VERSION}
        MessageBox MB_ICONEXCLAMATION|MB_OK "Установка WinEdt ${MUI_VERSION} KVicTools невозможна!$\n$\n\
        Для установки WinEdt ${MUI_VERSION} KVicTools требуется наличие предустановленного оригинального WinEdt версии ${MUI_VERSION}, в то время как предустановленный WinEdt имеет версию $OldInstallVersion.$\n$\n\
        Переустановите или установите заново WinEdt ${MUI_VERSION} в режиме 'Admin installation' после чего возобновите установку WinEdt KVicTools." /SD IDOK
        Abort
 ${EndIf}

FunctionEnd

