;WinEdt-10.3-KVicTools for WinEdt NSIS Install Script
;--------------------------------
;Header Files

!include "x64.nsh"
!include "MUI2.nsh"
!include "FileFunc.nsh"

;--------------------------------
;Constants

!define MUI_VERSION "10.3"
!define MUI_PRODUCT "WinEdt-${MUI_VERSION}-KVicTools"
!define MUI_BUILD "20180507"
!define MUI_COMPANY "WinEdt Team"
!define WINEDT_PRODUCT "WinEdt 10"
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

Var dialog
Var label1
Var label2
Var radiobutton1
Var radiobutton2
Var UserProfile
Var DesktopIcon
Var StartMenuIcon
Var AssociateFiles
Var UserProfileFolder
Var AccountType
Var RegAccountType
Var SystemAccountType
Var InstallAdmin
Var OldInstallLocation

;--------------------------------
;Installer Attributes

VIProductVersion "${MUI_VERSION}.${YEAR}.${BUILD_NUM}"
VIAddVersionKey ProductName "${MUI_PRODUCT}"
VIAddVersionKey CompanyName "${MUI_COMPANY}"
VIAddVersionKey LegalCopyright "Copyright (C) 2010-2019 by Victor Kozyakin"
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

;BrandingText "${MUI_COMPANY}"

;--------------------------------
;Installer Pages

!define MUI_WELCOMEPAGE_TITLE_3LINES
!insertmacro MUI_PAGE_WELCOME

!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "License_ru.rtf"

!define MUI_PAGE_HEADER_TEXT "Информация"
!define MUI_PAGE_HEADER_SUBTEXT "Пожалуйста, прежде чем продолжить прочитайте следующую информацию."
!define MUI_LICENSEPAGE_TEXT_TOP "Нажмите PageDown, чтобы увидеть продолжение информации."
!define MUI_LICENSEPAGE_TEXT_BOTTOM "Когда будете готовы, нажмите кнопку $\"Далее$\" для продолжения."
!define MUI_LICENSEPAGE_BUTTON "Далее >"
!insertmacro MUI_PAGE_LICENSE "Readme_ru.rtf"

Page custom InstallType InstallTypeLeave

!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_FINISHPAGE_RUN "$INSTDIR\WinEdt.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS "-V -E=%b\WinEdt.dnt [Exe('%b\WinShell\Install.edt');]"
!define MUI_FINISHPAGE_RUN_TEXT "Запуск WinEdt"
!insertmacro MUI_PAGE_FINISH

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "Russian"

;--------------------------------
;Installer Sections

ShowInstDetails show

Section "Full"
	MessageBox MB_ICONEXCLAMATION|MB_OK "$INSTDIR ... $UserProfileFolder"

  ;Copy Files
  SetOverwrite on
;  SetOutPath "$INSTDIR"
  SetOutPath "c:\temp\2"
        File /r "UserData\*.*"

SectionEnd

;--------------------------------
;Installer Functions

Function InstallType

  !insertmacro MUI_HEADER_TEXT "Тип установки" ""

  nsDialogs::Create 1018
        Pop $dialog
  ${NSD_CreateLabel} 0 0 100% 12% "После выбора типа установки нажмите кнопку $\"Далее$\" для продолжения."
        Pop $label1
  ${NSD_CreateLabel} 0 20% 100% 6% "Тип установки"
        Pop $label2
  ${NSD_CreateRadioButton} 5% 30% 100% 6% "Для всех пользователей"
        Pop $radiobutton1
  ${NSD_CreateRadioButton} 5% 40% 100% 6% "Для текущего пользователя"
        Pop $radiobutton2
        ${NSD_Check} $radiobutton2
  GetFunctionAddress $0 InstallTypeLeave
  nsDialogs::OnBack $0
  nsDialogs::Show

FunctionEnd

Function InstallTypeLeave

  ${NSD_GetState} $radiobutton1 $InstallAdmin

  ${If} $InstallAdmin == 1
  ${AndIf} $SystemAccountType != "Admin"
        MessageBox MB_ICONEXCLAMATION|MB_OK "Перезапустите инсталлятор с правами Администратора!"
        ${NSD_Uncheck} $radiobutton1
        ${NSD_Check} $radiobutton2
        Abort
  ${EndIf}
  ${If} $InstallAdmin == 1
  ${AndIf} $RegAccountType == "User"
        MessageBox MB_ICONEXCLAMATION|MB_OK "Тип установки ${WINEDT_PRODUCT} - $\"Для текущего пользователя$\".$\r\
                                             Поэтому Вы не можете выбрать тип установки ${MUI_PRODUCT} $\"Для всех пользователей$\"!"
        ${NSD_Uncheck} $radiobutton1
        ${NSD_Check} $radiobutton2
        Abort
  ${EndIf}

  ${If} $InstallAdmin == 1
        StrCpy $AccountType "Admin"
        SetShellVarContext all
  ${Else}
        StrCpy $AccountType "User"
        SetShellVarContext current
  ${EndIf}

  ;Default Installation Folder
  ReadRegStr $OldInstallLocation SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "InstallLocation"
  ${If} $OldInstallLocation != ""
        StrCpy $INSTDIR $OldInstallLocation
  ${Else}
        ${If} $AccountType == "Admin"
              ${If} $INSTDIR == ""
                    !ifndef WINEDT_32
                          StrCpy $INSTDIR "$PROGRAMFILES64\${MUI_COMPANY}\${WINEDT_PRODUCT}"
                    !else
                          StrCpy $INSTDIR "$PROGRAMFILES\${MUI_COMPANY}\${WINEDT_PRODUCT}"
                    !endif
              ${EndIf}
        ${Else}
              StrCpy $INSTDIR "$APPDATA\${MUI_COMPANY}\${WINEDT_PRODUCT}"
        ${EndIf}
  ${EndIf}

  ReadRegDWORD $UserProfile SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "UserProfile"
  ReadRegDWORD $StartMenuIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "StartMenuIcon"
  ReadRegDWORD $DesktopIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "DesktopIcon"
  ReadRegDWORD $AssociateFiles SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${WINEDT_PRODUCT}" "AssociateFiles"

FunctionEnd

;--------------------------------
;Init Functions

Function .onInit

	ReadRegStr $UserProfileFolder HKCU "Software\${WINEDT_PRODUCT}" "AppData"

  !ifndef WINEDT_32
        ${IfNot} ${RunningX64}
              MessageBox MB_OK "64-битная версия WinEdt не может быть установлена на 32-битной платформе" /SD IDOK
              Abort
        ${EndIf}
        SetRegView 64
  !endif

  ${GetParameters} $0
  ${GetOptions} $0 /USERPROFILE= $UserProfile
  ${If} $UserProfile == ""
        StrCpy $UserProfile "1"
  ${EndIf}
  ${GetOptions} $0 /STARTMENUICON= $StartMenuIcon
  ${If} $StartMenuIcon == ""
        StrCpy $StartMenuIcon "1"
  ${EndIf}
  ${GetOptions} $0 /DESKTOPICON= $DesktopIcon
  ${If} $DesktopIcon == ""
        StrCpy $DesktopIcon "1"
  ${EndIf}
  ${GetOptions} $0 /ASSOCIATEFILES= $AssociateFiles

  UserInfo::GetAccountType
        Pop $SystemAccountType
  ReadRegStr $RegAccountType HKCU "Software\${WINEDT_PRODUCT}" "AccountType"
  ${If} $SystemAccountType == "Admin"
        ${If} $RegAccountType == "Admin"
        ${OrIf} $RegAccountType == ""
              StrCpy $AccountType "Admin"
        ${Else}
              StrCpy $AccountType "User"
        ${EndIf}
  ${Else}
        StrCpy $AccountType "User"
  ${EndIf}

  ;Default Installation Folder for Silent Install
  ${If} ${Silent}
        ${If} $AccountType == "Admin"
              ${If} $INSTDIR == ""
                    !ifndef WINEDT_32
                          StrCpy $INSTDIR "$PROGRAMFILES64\${MUI_COMPANY}\${WINEDT_PRODUCT}"
                    !else
                          StrCpy $INSTDIR "$PROGRAMFILES\${MUI_COMPANY}\${WINEDT_PRODUCT}"
                    !endif
              ${EndIf}
              SetShellVarContext all
        ${Else}
              StrCpy $INSTDIR "$APPDATA\${MUI_COMPANY}\${WINEDT_PRODUCT}"
              SetShellVarContext current
        ${EndIf}
  ${EndIf}


FunctionEnd

