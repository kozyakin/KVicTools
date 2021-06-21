; MiKTeX 2.9 KVicTools Inno (Installer) Setup Script
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
#define BuildInfo AppVersion+'.'+Year+'.'+Build;
#define PublisherName 'KVicTools';

[Setup]
PrivilegesRequired=admin
AppName=MiKTeX {#PublisherName}
AppVerName=MiKTeX {#PublisherName}
AppPublisher=Victor Kozyakin
AppPublisherURL=http://www.iitp.ru/ru/users/46.htm
DefaultDirName={commonappdata}\MiKTeX
DefaultGroupName=MiKTeX
LicenseFile=License_ru.rtf
InfoBeforeFile=MiKTex_KVicTools_Readme_ru.rtf
AllowNoIcons=true
DirExistsWarning=no
UninstallDisplayName=MiKTeX {#PublisherName}
Uninstallable=true
OutputDir=.
DisableDirPage=true
OutputBaseFilename=setup-MiKTeX-{#PublisherName}
SolidCompression=true
AppVersion={#BuildInfo}
AppCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoVersion={#BuildInfo}
VersionInfoTextVersion={#BuildInfo}
ShowLanguageDialog=yes
UsePreviousAppDir=false
UninstallLogMode=overwrite
ChangesEnvironment=yes
WizardStyle=modern
Compression=lzma2/ultra
InternalCompressLevel=ultra

[Languages]
Name: ru; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: License_ru.rtf; InfoBeforeFile: MiKTex_KVicTools_Readme_ru.rtf

[Messages]
BeveledLabel={#PublisherName}

[Tasks]

[InstallDelete]
Name: {app}\miktex\config\*.*; Type: files

[Files]
Source: default\texmflocal\*.*; DestDir: {app}; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: disser\texmflocal\*.*; DestDir: {app}; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default disser

[Registry]
Root: "HKLM"; Subkey: SOFTWARE\Ghostgum\GSview; ValueType: dword; ValueName: Number; ValueData: 20233; Flags: createvalueifdoesntexist
Root: "HKLM"; Subkey: SOFTWARE\Ghostgum\GSview; ValueType: dword; ValueName: Receipt; ValueData: 22567; Flags: createvalueifdoesntexist

[Icons]

[UninstallDelete]

[Run]
Filename: "{code:BinRoot}\mpm.exe"; Parameters: "--admin --quiet --uninstall=lh"; Flags: skipifdoesntexist runminimized; StatusMsg: "Подготовка установки..."; Components: default
Filename: "{code:BinRoot}\mpm.exe"; Parameters: "--admin --quiet --uninstall=cm-super"; Flags: skipifdoesntexist runminimized; StatusMsg: "Подготовка установки..."; Components: default
Filename: "{code:BinRoot}\mpm.exe"; Parameters: "--admin --install=lh  --verbose"; Flags: skipifdoesntexist runminimized; StatusMsg: "Установка пакета CM-Super. Ждите..."; Components: cmsuper
Filename: "{code:BinRoot}\mpm.exe"; Parameters: "--admin --install=cm-super  --verbose"; Flags: skipifdoesntexist runminimized; StatusMsg: "Установка пакета CM-Super. Ждите..."; Components: cmsuper
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--admin --update-fndb --verbose"; Flags: skipifdoesntexist; StatusMsg: "Обновление базы данных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--dump --verbose"; Flags: skipifdoesntexist; StatusMsg: "Обновление форматных файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--admin --dump --verbose"; Flags: skipifdoesntexist; StatusMsg: "Обновление форматных файлов MiKTeX... ..."; Components: default
Filename: "{code:BinRoot}\mpm.exe"; Parameters: "--admin --update-db  --verbose"; Flags: skipifdoesntexist runminimized; StatusMsg: "Синхронизация локальной базы данных файлов MiKTeX с репозитарием..."; Components: default
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--admin --mklinks --verbose"; Flags: skipifdoesntexist runminimized; StatusMsg: "Обновление ссылок файлов MiKTeX..."; Components: default
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--admin --mkmaps --verbose"; Flags: skipifdoesntexist; StatusMsg: "Обновление map-файлов MiKTeX..."; Components: default

[UninstallRun]
Filename: "{code:BinRoot}\initexmf.exe"; Parameters: "--admin --dump --mkmaps --mklinks --update-fndb --verbose"; Flags: skipifdoesntexist; StatusMsg: "Обновление форматных файлов MiKTeX... ..."; RunOnceId: "miktex_kvic"; Components: default

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
  'Выбор директории установки', 'Корневая директория установки системы MiKTeX {#AppVersion} не найдена !',
  'Пожалуйста, для выбора корневой директории установки системы MiKTeX {#AppVersion} нажмите кнопку Обзор.',
  False, 'New Folder');
  PageInputDirWP.Add('');
// Set initial value (optional)
  PageInputDirWP.Values[0] := ExpandConstant('{pf}\MiKTeX {#AppVersion}');
  end else
  begin
    // Create the page
  PageInputDirWP := CreateInputDirPage(wpSelectDir,
  'Выбор директории установки', 'Обнаружена установленная система MiKTeX {#AppVersion} !',
  'Пожалуйста, подтвердите правильность выбора корневой директории установки системы MiKTeX {#AppVersion}, '+
  'нажав на кнопку Далее.'#13#10#13#10 +
  'Для ручного выбора корневой директории установки системы MiKTeX {#AppVersion} нажмите кнопку Обзор.',
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
Name: "cmsuper"; Description: "Пакет поддержки кириллических Type1 шрифтов CM-Super"; ExtraDiskSpaceRequired: 72000000; Types: custom full
Name: "disser"; Description: "Пакет Disser для оформления диссертаций"; Types: custom full
