; MiKTeX 20+ KVicTools Inno (Installer) Setup Script
; Prepared by Victor Kozyakin
; =====================================================================
;
; INNO Setup: http://www.innosetup.com
; ---------------------------------------------------------------------
#pragma option -v+
#pragma verboselevel 9

#define AppVersion '2.9';
#define Build ReadIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', '0');
#define Build Str(Int(Build)+1);
#expr WriteIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', Build);
#define Year GetDateTimeString('yyyy', '', '');
#define BuildInfo Year+'.'+Build;
#define PublisherName 'KVicTools';

[Setup]
PrivilegesRequired=lowest
AppName=MiKTeX {#PublisherName}
AppPublisher=Victor Kozyakin
AppPublisherURL=http://www.iitp.ru/ru/users/46.htm
AppVersion={#BuildInfo}
AppCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoVersion={#BuildInfo}
DefaultDirName={commonappdata}\MiKTeX
DefaultGroupName=MiKTeX
LicenseFile=License_ru.txt
InfoBeforeFile=MiKTex_KVicTools_Readme_ru.txt
AllowNoIcons=true
DirExistsWarning=no
UninstallDisplayName=MiKTeX {#PublisherName}
Uninstallable=true
OutputDir=.
DisableDirPage=true
OutputBaseFilename=setup-MiKTeX-{#PublisherName}
SolidCompression=true
ShowLanguageDialog=yes
UsePreviousAppDir=false
UninstallLogMode=overwrite
ChangesEnvironment=yes
WizardStyle=modern
Compression=lzma2/ultra
InternalCompressLevel=ultra

[Languages]
Name: ru; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: License_ru.txt; InfoBeforeFile: MiKTex_KVicTools_Readme_ru.txt

[Messages]
BeveledLabel={#PublisherName}

[Tasks]

[InstallDelete]
Name: {app}\miktex\config\*.*; Type: files

[Files]
Source: default\texmflocal\*.*; DestDir: {userappdata}\MiKTeX; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: gost705bib\texmflocal\*.*; DestDir: {userappdata}\MiKTeX;Flags: recursesubdirs overwritereadonly ignoreversion; Components: default gost705bib
Source: "User_home_dir\latexmkrc"; DestDir: "{%USERPROFILE}"; DestName: ".latexmkrc"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default

[Registry]

[Icons]

[UninstallDelete]

[Run]
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose packages install t2"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Установка пакета CM-Super. Ждите..."; Components: cmsuper
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose packages install gost"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Установка пакета CM-Super. Ждите..."; Components: cmsuper
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose packages install cm-super"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Установка пакета CM-Super. Ждите..."; Components: cmsuper
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose fndb refresh"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление базы данных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose formats build"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление форматных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose packages update-package-database"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Синхронизация локальной базы данных файлов MiKTeX с репозитарием..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose links install"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление ссылок файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose fontmaps configure"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление map-файлов MiKTeX..."; Components: default

[UninstallRun]
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose fndb refresh"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление базы данных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose formats build"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление форматных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose packages update-package-database"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Синхронизация локальной базы данных файлов MiKTeX с репозитарием..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose links install"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление ссылок файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\miktex.exe"; Parameters: "--verbose fontmaps configure"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление map-файлов MiKTeX..."; Components: default

[Code]
var
  PageInputDirWP: TInputDirWizardPage;
  InstallDir,AutoInstall: String;

function InstallRoot(Param: String): String;
begin
  Result := InstallDir;
end;

function BinRoot(Param: String): String;
begin
  if DirExists(InstallDir + '\miktex\bin\x64') 
  then Result := InstallDir + '\miktex\bin\x64'
  else Result := InstallDir + '\miktex\bin';
end;

procedure InitializeWizard;
var
	InstRoot: String;

begin

  AutoInstall := '';
  if not RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
	then if not RegQueryStringValue(HKCU, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
		then if not RegQueryStringValue(HKU, '.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
			then InstRoot:='';

  if IsWin64 then
  if InstRoot='' then
  if not RegQueryStringValue(HKLM64, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
	then if not RegQueryStringValue(HKCU64, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
		then if not RegQueryStringValue(HKU64, '.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MiKTeX', 'InstallLocation', InstRoot)
			then InstRoot:='';

	if  InstRoot='' then 
  begin
// Create the page
  PageInputDirWP := CreateInputDirPage(wpSelectDir,
  'Выбор директории установки', 'Корневая директория установки системы MiKTeX не найдена !',
  'Пожалуйста, для выбора корневой директории установки системы MiKTeX нажмите кнопку Обзор.',
  False, 'New Folder');
  PageInputDirWP.Add('');
// Set initial value (optional)
  PageInputDirWP.Values[0] := ExpandConstant('{pf}\MiKTeX');
  end else
  begin
    // Create the page
  PageInputDirWP := CreateInputDirPage(wpSelectDir,
  'Выбор директории установки', 'Обнаружена установленная система MiKTeX !',
  'Пожалуйста, подтвердите правильность выбора корневой директории установки системы MiKTeX, '+
  'нажав на кнопку Далее.'#13#10#13#10 +
  'Для ручного выбора корневой директории установки системы MiKTeX нажмите кнопку Обзор.',
  False, 'New Folder');
  PageInputDirWP.Add('');
// Set initial value (optional)
  PageInputDirWP.Values[0] := InstRoot;
// Save AutoInstall value
  if IsWin64 then
    begin
      if RegQueryStringValue(HKLM64, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', AutoInstall) then
         RegWriteStringValue(HKLM64, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', '2');
    end
  else 
    begin
      if RegQueryStringValue(HKLM, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', AutoInstall) then
         RegWriteStringValue(HKLM, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', '2');
    end
  end;
//  MsgBox(AutoInstall,mbInformation, MB_OK);
end;

procedure DeinitializeSetup();

begin

if Autoinstall<>'' then
  if IsWin64 then
    RegWriteStringValue(HKLM64, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', AutoInstall)
  else 
    RegWriteStringValue(HKLM, 'SOFTWARE\MiKTeX.org\MiKTeX\{#AppVersion}\MPM', 'AutoInstall', AutoInstall);

end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  { Validate certain pages before allowing the user to proceed }
  if CurPageID = PageInputDirWP.ID then 
    begin
    InstallDir := PageInputDirWP.Values[0];
    end;
    Result := True;
end;

[LangOptions]
LanguageName=Russian
LanguageID=$0419

[Components]
Name: "default"; Description: "Установка и конфигурация поддержки русского языка"; Types: custom compact full; Flags: fixed
Name: "cmsuper"; Description: "Пакеты поддержки кириллицы"; ExtraDiskSpaceRequired: 72000000; Types: custom full
Name: "gost705bib"; Description: "Библиографические стили GOST-705"; Types: custom full
